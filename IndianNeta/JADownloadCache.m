//
//  JADownloadCache.m
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "JADownloadCache.h"
#import "AbstractHTTPDataSource.h"

static JADownloadCache *sharedCache = nil;

@implementation JADownloadCache

- (id) init
{
	self = [super init];
	return self;
}

+ (id) sharedCache {
    
	if (!sharedCache) {
		sharedCache = [[self alloc] init];
	}
	return sharedCache;
}

+ (id) initCache {
    
	return [[[self alloc] init] autorelease];
}

+ (void) clearCachedResponsesForDataSource:(id)datasource
                             storagePolicy:(ASICacheStoragePolicy)storagePolicy {
    
    NSString *storagePath = CachePath([datasource cachePath]);
    
    JADownloadCache *downloadCache = [[self alloc] init];
    [downloadCache setStoragePath:storagePath];
    
    [downloadCache clearCachedResponsesForStoragePolicy:storagePolicy];
    
    [downloadCache release];
    
}

#pragma mark -

- (void) dealloc {
    
	[super dealloc];
}

@end
