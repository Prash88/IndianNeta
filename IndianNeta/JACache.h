//
//  JACache.h
//  JustAsk
//
//  Created by Vasanth on 01/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JACache : NSObject {
@private
	NSMutableDictionary* caches;
	NSOperationQueue* operationQueue;
	NSTimeInterval defaultCacheExpireInterval;
}

+ (JACache*)sharedInstance;

- (void)clearCache;
- (void)removeCacheForKey:(NSString*)key;

- (BOOL)hasCacheForKey:(NSString*)key;

- (NSData*)dataForKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key;
- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSString*)stringForKey:(NSString*)key;
- (void)setString:(NSString*)aString forKey:(NSString*)key;
- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (UIImage*)imageForKey:(NSString*)key;
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key;
- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (NSData*)plistForKey:(NSString*)key;
- (void)setPlist:(id)plistObject forKey:(NSString*)key;
- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key;
- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval;	

- (void)removeItemFromCache:(NSString*)key;
- (void)performDiskWriteOperation:(NSInvocation *)invoction;
- (void)saveCacheDictionary;
+ (NSString *) cacheDirectory;
+ (NSString *) keyForURL:(NSURL *)url;

@property(nonatomic,assign) NSTimeInterval defaultCacheExpireInterval;

@end