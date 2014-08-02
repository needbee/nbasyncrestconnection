//
//  NBDemoRestConnection.h
//
//  This class is a demo web service connection class you could create on top of
//  NBAsyncRestConnection.
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBAsyncRestConnection.h"

@protocol NBDemoRestConnectionDelegate;


// Note that it doesn't inherit from NBAsyncRestConnection; it functions as a
// delegate for it. NBDemoRestConnection will create its own NBAsyncRestConnection.
@interface NBDemoRestConnection : NSObject <NBAsyncRestConnectionDelegate>

@property (nonatomic,retain) NSString *baseUrl;
@property (nonatomic,retain) NSString *username;
@property (nonatomic,assign) NSInteger operation;
@property (nonatomic,retain) NBAsyncRestConnection *connection;
@property (nonatomic,retain) id<NBDemoRestConnectionDelegate> delegate;

// initialize the connection with basic connection data
-(id)initWithBaseUrl:(NSString *)baseUrl username:(NSString *)username;

// call a specific request, with the delegate in your ViewController to call back to
-(void)getCitiesWithinNorth:(double)n
                      south:(double)s
                       east:(double)e
                       west:(double)w
               withDelegate:(id<NBDemoRestConnectionDelegate>)delegate;

@end


// Your view controller will implement this protocol, to be notified when a connection
// succeeds or fails.
@protocol NBDemoRestConnectionDelegate<NSObject>

// There's just a single failure method
- (void)operationFailedWithStatusCode:(int)code
                              message:(NSString *)msg;

// Separate success method for each request, returing the pertinent data.
// Note that these are optional, because when there are many of them each view
// controller probably won't call all of them.
@optional

-(void)getCitiesOperationFinishedWithCities:(NSArray *)cities;

@end
