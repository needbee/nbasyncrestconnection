//
//  AsyncRestConnection.h
//
//  Created by Josh Justice on 10/28/10.
//  (c) 2011 NeedBee, LLC. All right reserved.
//

#import <Foundation/Foundation.h>

#define NBAsyncRestConnectionMethodGet @"GET"
#define NBAsyncRestConnectionMethodPut @"PUT"
#define NBAsyncRestConnectionMethodPost @"POST"
#define NBAsyncRestConnectionMethodPatch @"PATCH"
#define NBAsyncRestConnectionMethodDelete @"DELETE"

#define NBAsyncRestConnectionResponseCodeOk 200
#define NBAsyncRestConnectionResponseCodeCreated 201
#define NBAsyncRestConnectionResponseCodeNotFound 404

@protocol NBAsyncRestConnectionDelegate;


@interface NBAsyncRestConnection : NSObject

@property (nonatomic, assign) id<NBAsyncRestConnectionDelegate> delegate;
@property (nonatomic, assign) NSInteger responseCode;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSDictionary *receivedHeaders;

-(id) initWithURL:(NSString *)url
		 delegate:(id<NBAsyncRestConnectionDelegate>)delegate;

-(id) initWithURL:(NSString *)url
		  headers:(NSDictionary *)headers
		 delegate:(id<NBAsyncRestConnectionDelegate>)delegate;

-(id) initWithURL:(NSString *)url
		   method:(NSString *)method
		  headers:(NSDictionary *)headers
		 delegate:(id<NBAsyncRestConnectionDelegate>)delegate;

- (id) initWithURL:(NSString *)url
			method:(NSString *)method
			  body:(NSString *)body
		   headers:(NSDictionary *)headers
		  delegate:(id<NBAsyncRestConnectionDelegate>)delegate;

- (id) initWithURL:(NSString *)url
			method:(NSString *)method
			  body:(NSString *)body
       contentType:(NSString *)contentType
		   headers:(NSDictionary *)headers
		  delegate:(id<NBAsyncRestConnectionDelegate>)delegate;

@end


@protocol NBAsyncRestConnectionDelegate<NSObject>

- (void) connectionDidFail:(NBAsyncRestConnection *)theConnection;
- (void) connectionDidFinish:(NBAsyncRestConnection *)theConnection;

@end
