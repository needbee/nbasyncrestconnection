//
//  NBDemoRestConnection.m
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBDemoRestConnection.h"
#import "Geoname.h"

// If you're accessing an XML web service instead of a JSON one, you'd use a different parser
#import "SBJsonParser.h"

// An ID defined for each different operation/method, for keeping track
#define GET_CITIES_OP 0

@interface NBDemoRestConnection ()

@property (nonatomic,retain) SBJsonParser *parser;

@end



@implementation NBDemoRestConnection

-(id)initWithBaseUrl:(NSString *)baseUrl
              username:(NSString *)username
{
    if( self ) {
        self.baseUrl = baseUrl;
        self.username = username;
        self.parser = [[SBJsonParser alloc] init];
    }
    return self;
}

-(void)getCitiesWithinNorth:(double)n
                      south:(double)s
                       east:(double)e
                       west:(double)w
               withDelegate:(id<NBDemoRestConnectionDelegate>)d
{
    self.delegate = d;

    // Save what operation is being called. Each connection instance can only be
    // used to make one web service call at a time.
    self.operation = GET_CITIES_OP;

    // Form the URL. If this was a POST/PUT/PATCH, you'd also form the post data here
    NSString *url = [NSString stringWithFormat:@"%@/citiesJSON?north=%f&south=%f&east=%f&west=%f&username=%@", _baseUrl, n, s, e, w, _username];
    
    // Call the async connection, calling back to this class when done. It will
    // return bare string data, then this class will convert it to business objects.
    self.connection = [[NBAsyncRestConnection alloc] initWithURL:url
                                                          method:NBAsyncRestConnectionMethodGet
                                                         headers:nil
                                                        delegate:self];
}

#pragma mark - async rest connection delegate methods

-(void)connectionDidFail:(NBAsyncRestConnection *)c
{
	[_delegate operationFailedWithStatusCode:0
                                     message:@"Could not connect to server."];
}

// All connection successes go here; parse them all and call back
-(void)connectionDidFinish:(NBAsyncRestConnection *)c
{
	NSString *resultString = [[NSString alloc] initWithData:c.receivedData
												   encoding:NSUTF8StringEncoding];
	NSLog(@"result string: %@", resultString);
    
    // figure out which method was called
	switch( self.operation ) {
        case GET_CITIES_OP: {
            if( c.responseCode == NBAsyncRestConnectionResponseCodeOk ) {
                // turn the data into business objects
                NSDictionary *dict = [_parser objectWithString:resultString];
                NSArray *geonames = [Geoname arrayFromDictArray:[dict objectForKey:@"geonames"]];
                
                // call back to the view controller
                [_delegate getCitiesOperationFinishedWithCities:geonames];
            } else {
				[_delegate operationFailedWithStatusCode:c.responseCode
                                                 message:@"An error occurred getting cities."];
            }
        }
            break;
    }
}

@end
