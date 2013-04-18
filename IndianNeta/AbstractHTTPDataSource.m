//
//  AbstractHTTPDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "AbstractHTTPDataSource.h"
#import "Transformer.h"
#import "ASIHTTPRequest.h"
#import "JADownloadCache.h"
#import "Service.h"
#import "GlobalUtil.h"
#import "JANetwork.h"

#define DEFAULT_TIMEOUT @"25"

#pragma mark -
#pragma mark AbstractHTTPDataSource private

@interface AbstractHTTPDataSource (Private)

@end

@implementation AbstractHTTPDataSource

@synthesize url = _url, request = _request;
@synthesize params = _params, perPageResults, startIndex;
@synthesize serviceURL = _serviceURL;

-(id) initWithDelegate:(id)delegate{
	return [self initWithURL:nil delegate:delegate];
}

-(id) initWithDataSource:(AbstractHTTPDataSource *)datasource{
	
    if((self = [super initWithDataSource:datasource])){
		
		self.url = datasource.url;
		self.request = datasource.request;
		self.params = datasource.params;
        self.serviceURL = datasource.serviceURL;
        self.delegate = datasource.delegate;
	}
	
	return self;
}

-(id) initWithURL:(NSURL *)url delegate:(id)delegate{
	
    if((self = [super init])){
		self.delegate = delegate;
		self.url = url;
	}
	
	if(self.url == nil){
		
	}
	
	self.startIndex = 0;
	
	[self prepareRequest];
	
	return self;
}

- (void) clearDelegatesAndCancel {
    [_request clearDelegatesAndCancel];
    self.delegate = nil;
}

#pragma mark -

- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[self initRequest];
	
	self.request.userInfo = [NSMutableDictionary dictionaryWithObject:[self class] forKey:@"dsClass"];
	
	[self.request setTimeOutSeconds:[self dataSourceTimeOutPeriod]];
	
	NSString *postData = [self requestPOSTContent];
	
	RequestMethod method = [self requestMethod];
	
	if(postData != nil){
		method = POST;
	}
	
	[self.request setRequestMethod:[self HTTPVerbStringForType:method]];
	
	[self decorateRequest:postData];
	
	//	[self.request startAsynchronous];
	
	[self dispatchSelector:@selector(requestStarted:)
                    target:self
                   objects:[NSArray arrayWithObjects:self.request, nil]
              onMainThread:YES];
	
	[self.request startSynchronous];
	
	NetworkRequestStopped();
	
	NSError *error = [self.request error];
	
    if (!error) {
		
        [self requestFinished:self.request];
        
        if ([self.request didUseCachedResponse]) {
            NSLog(@"YES !! Serving from Cache");
        }
        
	} else {
		
		[self dispatchSelector:@selector(requestFailed:)
                        target:self
                       objects:[NSArray arrayWithObjects:self.request, nil]
                  onMainThread:YES];
	}
	
	
	[pool release];
}

- (int)dataSourceTimeOutPeriod{
	int timeout = [DEFAULT_TIMEOUT intValue];
	return timeout;
}

#pragma mark -

-(BOOL) isJSON{
	return FALSE;
}

-(RequestMethod) requestMethod{
	return GET;
}

-(NSString *) path{
	return nil;
}

-(NSString *) serviceForDataSource{
	return nil;
}

-(Class) transformerForDataSource{
	return nil;
}

-(Class) composer{
	return nil;
}

-(void)fillParams{
	// Do nothing
}

-(void)initRequest{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:self.url];
    
    // Setup Cache
		
		JADownloadCache *cache = [JADownloadCache initCache];
		self.jaDownloadCache = cache;
		[request setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy];
		[request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
		[request setDownloadCache:self.jaDownloadCache];
        
		// Set storage path for the cache
		[self.jaDownloadCache setStoragePath:CachePath([self cachePath])];
        self.request = request;

	
}

-(void)prepareRequest{
	NSMutableDictionary *params_ = [[NSMutableDictionary alloc] init];
	self.params = params_;
	[params_ release];
	
	[self fillParams];
	
	if ([self.delegate respondsToSelector:@selector(fillParametersForDataSource:)]) {
		NSMutableDictionary *parameters = [self.delegate fillParametersForDataSource:self];
		if (parameters != nil) {
			[self.params addEntriesFromDictionary:parameters];
		}
	}
	
	NSString *queryString = [[self class] queryDictionaryToString:self.params];
	NSString *dsURL = [[Service sharedInstance] serviceURLForDataSource:[self serviceForDataSource]];
	
	if(!IsEmptyString(self.path)){
		NSString *format = [self.path hasPrefix:@"/"] ? @"%@%@" : @"%@/%@";
		dsURL = [NSString stringWithFormat:format, dsURL, [self path]];
	}
	
	self.serviceURL = dsURL;
	
	if(!IsEmptyString(queryString)){
        dsURL = [NSString stringWithFormat:@"%@?%@", dsURL, queryString];
	}
	
	self.url = [NSURL URLWithString:dsURL];
	
	NSLog(@"DS URL: %@", self.url);
}

- (void) decorateRequest:(NSString *)postData {
    
	if(!IsEmptyString(postData)){
		[self.request appendPostData:[postData dataUsingEncoding:NSUTF8StringEncoding]];
		[self.request addRequestHeader:@"Content-Type" value:@"application/json"];
	}
	
	if([self isJSON]){
		[self.request addRequestHeader:@"Accept" value:@"application/json"];
	}
}

- (NSString *) HTTPVerbStringForType:(RequestMethod)method {
	
	NSString *requestMethod = @"";
	
	switch (method) {
		case 1:
			requestMethod = @"POST";
			break;
		case 2:
			requestMethod = @"DELETE";
			break;
		case 3:
			requestMethod = @"PUT";
			break;
		default:
			requestMethod = @"GET";
			break;
	}
	return requestMethod;
}

-(void)startAsynchronous{
	[self initRequest];
	
	self.request.userInfo = [NSMutableDictionary dictionaryWithObject:[self class] forKey:@"dsClass"];
	[self.request setTimeOutSeconds:20];
	
	NSString *postData = [self requestPOSTContent];
	
	RequestMethod method = [self requestMethod];
	
	if(postData != nil){
		method = POST;
	}
	
	[self.request setRequestMethod:[self HTTPVerbStringForType:method]];
	
	[self decorateRequest:postData];
	
	[self.request startAsynchronous];
}

-(NSString *) requestPOSTContent{
	return nil;
}

-(id)transform:(ASIHTTPRequest *)request{
	
	id model = nil;
	
	Class transformerClass = [self transformerForDataSource];
	
	if(transformerClass != nil){
		id transformer = [[transformerClass alloc] init];
		model = [transformer transform:request];
		[[model retain] autorelease];
		[transformer release];
	}
	
	return model;
}

-(id)compose:(id)model{
	id renderReadydata = nil;
	
	Class composerClass = [self composer];
	
	if(composerClass != nil){
        
		id composer = [[composerClass alloc] init];
		renderReadydata = [composer compose:model];
		[[renderReadydata retain] autorelease];
        [composer release];
		
    }
	
	return renderReadydata;
}

-(SEL) didStartSelector{
	return nil;
}

-(SEL) didFinishSelector{
	return nil;
}

-(SEL) didFailSelector{
	return nil;
}

- (void) loadMore{
	self.startIndex += self.perPageResults;
	
	[self prepareRequest];
	//[self startAsynchronous];
}

- (void) refresh{
	self.startIndex = 0;
	
	[self prepareRequest];
	//[self startAsynchronous];
}

- (NSString*) pathToStoreCacheData{
	return nil;
}

- (NSString*) cachePath{
    
    //default cache
    NSString *pathToCacheData = NSStringFromClass([self class]);
    
    NSString *dataSourceSpecificCache = [self pathToStoreCacheData];
    
    //over-ride default cache
    if(!IsEmptyString(dataSourceSpecificCache)){
        
        pathToCacheData = dataSourceSpecificCache;
        
    }
    
    return pathToCacheData;
}

+ (void) triggerRequestWithDelegate:(id)delegate{
	
    Class dscClass = [self class];
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	id dsc = [[dscClass alloc] initWithDelegate:delegate];
	[queue addOperation:dsc];
	[dsc release];
	[queue release];
    
}

+ (NSString *)queryDictionaryToString:(NSDictionary *)query {
	
	NSMutableArray *queryArray = [[NSMutableArray alloc] init];
	for (id key in query) {
		[queryArray addObject:[NSString stringWithFormat:@"%@=%@", key, [query objectForKey:key]]];
	}
	
	NSString *queryString = [queryArray componentsJoinedByString:@"&"];
	[queryArray release];
	
	queryString = [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return queryString;
}

- (void) processResponse:(ASIHTTPRequest *) request{
	
    NetworkRequestStopped();
	
    self.lastUpdatedAt = [NSDate date];
    
	SEL successCallback = @selector(requestFinished:product:);
	
	if ([self didFinishSelector] != nil) {
		successCallback = [self didFinishSelector];
	}
	
    NSLog(@"Finished downlaoding response for %@; it weighs %llu bytes", [self class], [request contentLength]);
    
	if(![self isCancelled] && [self.delegate respondsToSelector:successCallback]){
		
        NSLog(@"Started parsing response for %@ ", [self class]);
        
        id product = [self transform:request];
		
        NSLog(@"Finished parsing response for %@ ", [self class]);
        
		if([self composer] != nil){
			product = [self massageModelData:product];
            
            NSLog(@"Finished composing response for %@ ", [self class]);
		}
		
		[self dispatchSelector:successCallback
                        target:self.delegate
                       objects:[NSArray arrayWithObjects:self.request, product, nil]
                  onMainThread:YES];
	}
}

- (id)massageModelData:(id)product{
	
	id massagedData = nil;
	
	if(product){
		massagedData = (NSMutableArray*)[self compose:product];
	}
	return (NSMutableArray*)massagedData;
}

#pragma mark -
#pragma mark ASIHTTPRequest Delegate methods

- (void)requestStarted:(ASIHTTPRequest *)request
{
	NetworkRequestStarted();
	
	SEL startCallBack = @selector(requestStarted:);
	
	if ([self didStartSelector] != nil) {
		startCallBack = [self didStartSelector];
	}
	
	if([self.delegate respondsToSelector:startCallBack]){
		[self.delegate performSelector:startCallBack
                            withObject:request];
	}
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	
	if(![self isCancelled]){
		[self processResponse:request];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NetworkRequestStopped();
	
	SEL failureCallback = @selector(requestFailed:);
	
	if ([self didFailSelector] != nil) {
		failureCallback = [self didFailSelector];
	}
	
	NSError *error = [request error];
	NSLog(@"Error! : Request for %@ faile with Error code %d, Desc: %@", [request url], [error code], [error localizedDescription]);
	if([self.delegate respondsToSelector:failureCallback]){
		[self.delegate performSelector:failureCallback
                            withObject:request];
	}
}

#pragma mark -

- (void) dealloc{
    [_request release], _request = nil;
    [_jaDownloadCache release], _jaDownloadCache = nil;
    [_params release], _params = nil;
    [_url release], _url = nil;
    [_serviceURL release], _serviceURL = nil;
    [_lastUpdatedAt release], _lastUpdatedAt = nil;
    [super dealloc]; 
}

@end