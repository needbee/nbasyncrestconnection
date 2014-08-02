NBAsyncRestConnection
=====================

A class for performing asynchronous RESTful HTTP connections.

Demo
====

The demo/ folder contains a demo project showing NBAsyncRestConnection in use. Run `pod install` in it, then run it.

Usage
=====

A NBAsyncRestConnection is instantiated with as little or much connection data as you need:

	// simplest form, for GET requests
	[[NBAsyncRestConnection alloc] initWithURL:myurl
	    delegate:self];
	    
	// most complex form
	[[NBAsyncRestConnection alloc]
		initWithURL:myurl
			 method:NBAsyncRestConnectionMethodPost
			   body:myBodyString
		contentType:@"application/json"
		    headers:myHeaderDict
		   delegate:self];

The HTTP request happens immediately upon init. Make sure you save the connection object somewhere so it isn't deallocated before the request returns.

Your view controller should conform to the NBAsyncRestConnectionDelegate protocol, which has the following methods:

	- (void) connectionDidFail:(NBAsyncRestConnection *)theConnection;
	- (void) connectionDidFinish:(NBAsyncRestConnection *)theConnection;

Within these methods, you have access to the following fields on the NBAsyncRestConnection:

	@property (nonatomic, assign) NSInteger responseCode;
	@property (nonatomic, retain) NSMutableData *receivedData;
	@property (nonatomic, retain) NSDictionary *receivedHeaders;

The recommended usage of this class is to create your own rest connection class that defines your methods and maps to business objects. For example:

	@interface NBDemoRestConnection : NSObject <NBAsyncRestConnectionDelegate>

	-(void)getCitiesWithinNorth:(double)n
                      south:(double)s
                       east:(double)e
                       west:(double)w
               withDelegate:(id<NBDemoRestConnectionDelegate>)delegate;

	@end

You would also define your own delegate protocol with the callback methods returning business objects:

	@protocol NBDemoRestConnectionDelegate<NSObject>

		-(void)getCitiesOperationFinishedWithCities:(NSArray *)cities;

	@end

View the demo for details on how to implement this.

Compatibility
=============

This class has been tested back to iOS 5.0.

Implementation
==============

This class delegates to a NSURLConnection for HTTP requests, and wraps it with convenience methods.

License
=======

This code is released under the MIT License. See the LICENSE file for
details.