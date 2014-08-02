//
//  AsyncRestConnection.m
//
//  Created by Josh Justice on 10/28/10.
//  (c) 2011 NeedBee, LLC. All right reserved.
//

#import "NBAsyncRestConnection.h"

#define NBAsyncRestConnectionHeaderContentType @"Content-Type"

@implementation NBAsyncRestConnection

@synthesize responseCode;
@synthesize receivedData;
@synthesize connection;
@synthesize delegate;
@synthesize receivedHeaders;

-(id) initWithURL:(NSString *)u
		 delegate:(id<NBAsyncRestConnectionDelegate>)d
{
	return [self initWithURL:u
					  method:NBAsyncRestConnectionMethodGet
						body:nil
					 headers:nil
					delegate:d];
}

-(id) initWithURL:(NSString *)u
		  headers:(NSDictionary *)h
		 delegate:(id<NBAsyncRestConnectionDelegate>)d
{
	return [self initWithURL:u
					  method:NBAsyncRestConnectionMethodGet
						body:nil
					 headers:h
					delegate:d];
}

-(id) initWithURL:(NSString *)u
		   method:(NSString *)m
		  headers:(NSDictionary *)h
		 delegate:(id<NBAsyncRestConnectionDelegate>)d
{
	return [self initWithURL:u
					  method:m
						body:nil
					 headers:h
					delegate:d];
}

- (id) initWithURL:(NSString *)u
			method:(NSString *)m
			  body:(NSString *)b
		   headers:(NSDictionary *)h
		  delegate:(id<NBAsyncRestConnectionDelegate>)d
{
	return [self initWithURL:u
					  method:m
						body:b
                 contentType:nil
					 headers:h
					delegate:d];
}

- (id) initWithURL:(NSString *)u
			method:(NSString *)m
			  body:(NSString *)b
       contentType:(NSString *)ct
		   headers:(NSDictionary *)h
		  delegate:(id<NBAsyncRestConnectionDelegate>)d
{
	if (self = [super init]) {
		self.delegate = d;
		
		NSURL *url = [NSURL URLWithString:u];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		
		// set up the request
		if( nil != m ) {
			[request setHTTPMethod:m];
		}
		if( nil != b ) {
			NSData *bodyData = [b dataUsingEncoding:NSUTF8StringEncoding];
			[request setHTTPBody:bodyData];
			NSLog(@"body: %@", b);
		}
        if( nil != ct ) {
            if( nil == h ) {
                h = [NSDictionary dictionaryWithObject:ct
                                                forKey:NBAsyncRestConnectionHeaderContentType];
            } else {
                h = [NSMutableDictionary dictionaryWithDictionary:h];
                [(NSMutableDictionary *)h setObject:ct
                                             forKey:NBAsyncRestConnectionHeaderContentType];
            }
        }
		if( nil != h ) {
			NSEnumerator *e = [h keyEnumerator];
			NSString *headerName;
			while( headerName = [e nextObject] ) {
				[request setValue:[h objectForKey:headerName]
			   forHTTPHeaderField:headerName];
			}
		}
        [request setValue:@"" forHTTPHeaderField:@"Accept-Encoding"];

		NSLog(@"%@ request to %@",m,u);
//		NSLog(@"Header Authorization = %@", [h objectForKey:@"Authorization"]);
		self.connection = [NSURLConnection connectionWithRequest:request
														delegate:self];
		if (self.connection == nil) {
			[self.delegate connectionDidFail:self];
		}
	}
	
	return self;
}

#pragma mark - 
#pragma mark NSURLConnection delegate methods

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if( [response isKindOfClass:[NSHTTPURLResponse class]] ) {
        
		self.responseCode = ((NSHTTPURLResponse *)response).statusCode;
        self.receivedHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
	}
	long long contentLength = [response expectedContentLength];
	if (contentLength == NSURLResponseUnknownLength) {
		contentLength = 500000;
	}
	self.receivedData = [NSMutableData dataWithCapacity:(NSUInteger)contentLength];
}


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[self.delegate connectionDidFail:self];
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self.delegate connectionDidFinish:self];
}

@end
