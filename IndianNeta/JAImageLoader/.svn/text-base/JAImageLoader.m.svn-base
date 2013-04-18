//
//  JAImageLoader.m
//  JustAsk
//
//  Created by askdev on 28/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "JAImageLoader.h"
#import "JAImageLoadConnection.h"
#import "JACache.h"

static JAImageLoader* __imageLoader;

inline static NSString* keyForURL(NSURL* url) {
	return [NSString stringWithFormat:@"JAImageLoader-%u", [[url description] hash]];
}

#define kImageNotificationLoaded(s) [@"kJAImageLoaderNotificationLoaded-" stringByAppendingString:keyForURL(s)]
#define kImageNotificationLoadFailed(s) [@"kJAImageLoaderNotificationLoadFailed-" stringByAppendingString:keyForURL(s)]

@implementation JAImageLoader
@synthesize currentConnections=_currentConnections;

+ (JAImageLoader*)sharedImageLoader {
	@synchronized(self) {
		if(!__imageLoader) {
			__imageLoader = [[[self class] alloc] init];
		}
	}
	
	return __imageLoader;
}

- (id)init {
	if((self = [super init])) {
		connectionsLock = [[NSLock alloc] init];
		currentConnections = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (JAImageLoadConnection*)loadingConnectionForURL:(NSURL*)aURL {
	JAImageLoadConnection* connection = [[self.currentConnections objectForKey:aURL] retain];
	if(!connection) return nil;
	else return [connection autorelease];
}

- (void)cleanUpConnection:(JAImageLoadConnection*)connection {
	if(!connection.imageURL) return;
	
	connection.delegate = nil;
	
	[connectionsLock lock];
	[currentConnections removeObjectForKey:connection.imageURL];
	self.currentConnections = [[currentConnections copy] autorelease];
	[connectionsLock unlock];	
}

- (BOOL)isLoadingImageURL:(NSURL*)aURL {
	return [self loadingConnectionForURL:aURL] ? YES : NO;
}

- (void)cancelLoadForURL:(NSURL*)aURL {
	JAImageLoadConnection* connection = [self loadingConnectionForURL:aURL];
	[NSObject cancelPreviousPerformRequestsWithTarget:connection selector:@selector(start) object:nil];
	[connection cancel];
	[self cleanUpConnection:connection];
}

- (void)loadImageForURL:(NSURL*)aURL observer:(id<JAImageLoaderObserver>)observer {
	if(!aURL || !observer) return;
	
	if([observer respondsToSelector:@selector(imageLoaderDidLoad:)]) {
		[[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(imageLoaderDidLoad:) name:kImageNotificationLoaded(aURL) object:self];
	}
	
	if([observer respondsToSelector:@selector(imageLoaderDidFailToLoad:)]) {
		[[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(imageLoaderDidFailToLoad:) name:kImageNotificationLoadFailed(aURL) object:self];
	}
	
	if([self loadingConnectionForURL:aURL]) {
		return;
	}
	
	JAImageLoadConnection* connection = [[JAImageLoadConnection alloc] initWithImageURL:aURL delegate:self];

	[connectionsLock lock];
	[currentConnections setObject:connection forKey:aURL];
	self.currentConnections = [[currentConnections copy] autorelease];
	[connectionsLock unlock];
	[connection performSelector:@selector(start) withObject:nil afterDelay:0.01];
	[connection release];
}

- (UIImage*)imageForURL:(NSURL*)aURL shouldLoadWithObserver:(id<JAImageLoaderObserver>)observer {
	if(!aURL) return nil;
	
	UIImage* anImage = [[JACache sharedInstance] imageForKey:keyForURL(aURL)];
	
	if(anImage) {
		return anImage;
	} else {
		[self loadImageForURL:(NSURL*)aURL observer:observer];
		return nil;
	}
}

- (BOOL)hasLoadedImageURL:(NSURL*)aURL {
	return [[JACache sharedInstance] hasCacheForKey:keyForURL(aURL)];
}

- (void)removeObserver:(id<JAImageLoaderObserver>)observer {
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:nil object:self];
}

- (void)removeObserver:(id<JAImageLoaderObserver>)observer forURL:(NSURL*)aURL {
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:kImageNotificationLoaded(aURL) object:self];
	[[NSNotificationCenter defaultCenter] removeObserver:observer name:kImageNotificationLoadFailed(aURL) object:self];
}

#pragma mark -
#pragma mark URL Connection delegate methods

- (void)imageLoadConnectionDidFinishLoading:(JAImageLoadConnection *)connection {
	UIImage* anImage = [UIImage imageWithData:connection.responseData];
	
	if(!anImage) {
		NSError* error = [NSError errorWithDomain:[connection.imageURL host] code:406 userInfo:nil];
		NSNotification* notification = [NSNotification notificationWithName:kImageNotificationLoadFailed(connection.imageURL)
																	 object:self
																   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error,@"error",connection.imageURL,@"imageURL",nil]];
		if (notification != nil) {
			[[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:YES];
		}
	} else {
		[[JACache sharedInstance] setData:connection.responseData forKey:keyForURL(connection.imageURL) withTimeoutInterval:604800];
		
		[currentConnections removeObjectForKey:connection.imageURL];
		self.currentConnections = [[currentConnections copy] autorelease];
		
		NSNotification* notification = [NSNotification notificationWithName:kImageNotificationLoaded(connection.imageURL)
																	 object:self
																   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:anImage,@"image",connection.imageURL,@"imageURL",nil]];
		if (notification != nil) {
			[[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:YES];
		}
	}

	[self cleanUpConnection:connection];
}

- (void)imageLoadConnection:(JAImageLoadConnection *)connection didFailWithError:(NSError *)error {
	[currentConnections removeObjectForKey:connection.imageURL];
	self.currentConnections = [[currentConnections copy] autorelease];
	
	NSNotification* notification = [NSNotification notificationWithName:kImageNotificationLoadFailed(connection.imageURL)
																 object:self
															   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:error,@"error",connection.imageURL,@"imageURL",nil]];
	if (notification != nil) {
		//[[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:YES];
	}
	[self cleanUpConnection:connection];
}

#pragma mark -

- (void)dealloc {
	[_currentConnections release], _currentConnections = nil;
	[connectionsLock release];
	[super dealloc];
}

@end