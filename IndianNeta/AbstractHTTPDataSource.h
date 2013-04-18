//
//  AbstractHTTPDataSource.h
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "ASIHTTPRequest.h"
#import "JADownloadCache.h"
#import "ASIFormDataRequest.h"


typedef enum RequestMethod {
	GET = 0,
	POST = 1,
	DELETE = 2,
	PUT = 3
} RequestMethod;

@interface AbstractHTTPDataSource : DataSource<ASIHTTPRequestDelegate> {
	NSMutableDictionary *_params;
	NSURL *_url;
	ASIHTTPRequest *_request;
    JADownloadCache *_jaDownloadCache;
	NSInteger startIndex;
@private
	NSString *_serviceURL;
    
    /**
     The last updated time for the datasource
     */
    NSDate *_lastUpdatedAt;
}

@property(nonatomic, retain) NSMutableDictionary *params;
@property(nonatomic, retain) NSURL *url;
@property(nonatomic, retain) NSString *serviceURL;
@property(nonatomic, retain) ASIHTTPRequest *request;
@property(assign) NSInteger startIndex;
@property(assign) NSInteger max;
@property(assign) NSInteger perPageResults;
@property(nonatomic, retain) JADownloadCache *jaDownloadCache;
@property(nonatomic, retain) NSDate *lastUpdatedAt;

-(id) initWithURL:(NSURL *)url delegate:(id)delegate;
// Run request in the background
-(void) startAsynchronous;

- (int) dataSourceTimeOutPeriod;

- (void) clearDelegatesAndCancel;

+ (void) triggerRequestWithDelegate:(id)delegate;

@end

@interface DataSource (RequestDecoration)

// Fill the Request object, Subclasses must over-ride and provide implementation
-(void) fillParams;

// Creates a Request object
-(void) initRequest;

// Used to prepare the Request Object, for filling the request Headers
-(void) prepareRequest;

-(NSString *) serviceForDataSource;

// Over-ride to fill dynamic path param
-(NSString *) path;

// Transformer class, to be used for transforming response into Model objects
-(Class) transformerForDataSource;

// Over-ride if response needs to be JSON. Default: XML
-(BOOL) isJSON;

// HTTP Verb, Default: GET
-(RequestMethod) requestMethod;

// Over-ride to provide JSON post data
-(NSString *) requestPOSTContent;

- (NSString *) HTTPVerbStringForType:(RequestMethod)method;

/**
 Returns a path to store cached data
 @returns NSString path to store cached data
 */
- (NSString*)pathToStoreCacheData;

/**
 Returns a path to store cache data
 @returns NSString path to store cached data
 */
- (NSString*) cachePath;

// Helper Methods
+(NSString *) queryDictionaryToString:(NSDictionary *)query;

-(void) decorateRequest:(NSString *) postData;

//Composer to massgae data to be rendered with UI specific additional logic if any

-(Class) composer;

-(SEL) didStartSelector;

-(SEL) didFinishSelector;

-(SEL) didFailSelector;

@end


@interface DataSource (Transform)

// Used to transform the response data into cutomized Application Model Objects
-(id) transform:(ASIHTTPRequest *)request;

-(void) processResponse:(ASIHTTPRequest *) request;

@end

@interface DataSource (Composer)

// Used to massage transformed model data before rendering
- (id)compose:(id)model;

- (id)massageModelData:(id)product;

@end

@interface DataSource(Pagination)

// Load next set of results, based on 'perPageResults' variable
- (void) loadMore;

- (void) refresh;

@end

/**
 * DataSource Delegate
 */
@protocol DataSourceDelegate<NSObject>

@optional

// Triggerred when the Request is initiated
- (void)requestStarted:(ASIHTTPRequest *)request;

// Triggerred when a request completes successfully
- (void)requestFinished:(ASIHTTPRequest *)request product:(id)product;

// Triggerred when a request fails with an Error
- (void)requestFailed:(ASIHTTPRequest *)request;

- (NSMutableDictionary *) fillParametersForDataSource:(id)dataSourceClass;

@end
