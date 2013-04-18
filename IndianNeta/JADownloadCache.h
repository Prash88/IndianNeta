//
//  JADownloadCache.h
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"
#import "ASIHTTPRequest.h"

/**
 JADownloadCache is responsible to cache the response of GET requests
 Extension of ASIDownloadCache to faciliate custom storage type other
 than file system.
 @author Prakashini
 */
@interface JADownloadCache : ASIDownloadCache {
    
}

/**
 Returns a static instance of an JADownloadCache
 */
+ (id) sharedCache;

/**
 Convenience method to initialize JADownloadCache
 */
+ (id) initCache;

/**
 Clear the entire cached responses for the given datasource and policy
 @param datasource the datasource cache to be cleared
 @param storagePolicy the storage policy for which, data has to be cleared
 */
+ (void)clearCachedResponsesForDataSource:(id)datasource
                            storagePolicy:(ASICacheStoragePolicy)storagePolicy;

@end
