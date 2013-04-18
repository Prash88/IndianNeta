//
//  JACache.h
//  JustAsk
//
//  Created by Vasanth on 01/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "JACache.h"
#import "SynthesizeSingleton.h"

static NSString *cacheDirectory;

static inline NSString* cachePathForKey(NSString* key) {
	return [[JACache cacheDirectory] stringByAppendingPathComponent:key];
}

#pragma mark -

@implementation JACache

SYNTHESIZE_SINGLETON_FOR_CLASS(JACache);

@synthesize defaultCacheExpireInterval;

- (id)init {
	if((self = [super init])) {
		NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:cachePathForKey(@"JACache.plist")];
		
		if([dict isKindOfClass:[NSDictionary class]]) {
			caches = [dict mutableCopy];
		} else {
			caches = [[NSMutableDictionary alloc] init];
		}
		
		operationQueue = [[NSOperationQueue alloc] init];
		
		[[NSFileManager defaultManager] createDirectoryAtPath:[JACache cacheDirectory] 
															withIntermediateDirectories:YES 
																							 attributes:nil 
																										error:NULL];
		
		for(NSString* key in caches) {
			NSDate* date = [caches objectForKey:key];
			if([[[NSDate date] earlierDate:date] isEqualToDate:date]) {
				[[NSFileManager defaultManager] removeItemAtPath:cachePathForKey(key) error:NULL];
			}
		}
	}
	
	self.defaultCacheExpireInterval = 86400;
	
	return self;
}

- (void)clearCache {
	for(NSString* key in [caches allKeys]) {
		[self removeItemFromCache:key];
	}
	
	[self saveCacheDictionary];
}

- (void)removeCacheForKey:(NSString*)key {
	[self removeItemFromCache:key];
	[self saveCacheDictionary];
}

- (void)removeItemFromCache:(NSString*)key {
	NSString* cachePath = cachePathForKey(key);
	
	NSInvocation* deleteInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(deleteDataAtPath:)]];
	[deleteInvocation setTarget:self];
	[deleteInvocation setSelector:@selector(deleteDataAtPath:)];
	[deleteInvocation setArgument:&cachePath atIndex:2];
	
	[self performDiskWriteOperation:deleteInvocation];
	[caches removeObjectForKey:key];
}

- (BOOL)hasCacheForKey:(NSString*)key {
	NSDate* date = [caches objectForKey:key];
	if(!date) return NO;
	if([[[NSDate date] earlierDate:date] isEqualToDate:date]) return NO;
	return [[NSFileManager defaultManager] fileExistsAtPath:cachePathForKey(key)];
}

#pragma mark -
#pragma mark Copy file methods

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key {
	[self copyFilePath:filePath asKey:key withTimeoutInterval:self.defaultCacheExpireInterval];
}

- (void)copyFilePath:(NSString*)filePath asKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[[NSFileManager defaultManager] copyItemAtPath:filePath toPath:cachePathForKey(key) error:NULL];
	[caches setObject:[NSDate dateWithTimeIntervalSinceNow:timeoutInterval] forKey:key];
	[self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES];
}																												   

#pragma mark -
#pragma mark Data methods

- (void)setData:(NSData*)data forKey:(NSString*)key {
	[self setData:data forKey:key withTimeoutInterval:self.defaultCacheExpireInterval];
}

- (void)setData:(NSData*)data forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	
	NSString* cachePath = cachePathForKey(key);
	NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
	[writeInvocation setTarget:self];
	[writeInvocation setSelector:@selector(writeData:toPath:)];
	[writeInvocation setArgument:&data atIndex:2];
	[writeInvocation setArgument:&cachePath atIndex:3];
	
	[self performDiskWriteOperation:writeInvocation];
	[caches setObject:[NSDate dateWithTimeIntervalSinceNow:timeoutInterval] forKey:key];
	
	[self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES]; // Need to make sure the save delay get scheduled in the main runloop, not the current threads
}

- (void)saveAfterDelay {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(saveCacheDictionary) object:nil];
	[self performSelector:@selector(saveCacheDictionary) withObject:nil afterDelay:0.3];
}

- (NSData*)dataForKey:(NSString*)key {
	if([self hasCacheForKey:key]) {
		return [NSData dataWithContentsOfFile:cachePathForKey(key) options:0 error:NULL];
	} else {
		return nil;
	}
}

- (void)writeData:(NSData*)data toPath:(NSString *)path; {
	[data writeToFile:path atomically:YES];
} 

- (void)deleteDataAtPath:(NSString *)path {
	[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (void)saveCacheDictionary {
	@synchronized(self) {
		[caches writeToFile:cachePathForKey(@"JACache.plist") atomically:YES];
	}
}

#pragma mark -
#pragma mark String methods

- (NSString*)stringForKey:(NSString*)key {
	return [[[NSString alloc] initWithData:[self dataForKey:key] encoding:NSUTF8StringEncoding] autorelease];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key {
	[self setString:aString forKey:key withTimeoutInterval:self.defaultCacheExpireInterval];
}

- (void)setString:(NSString*)aString forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:[aString dataUsingEncoding:NSUTF8StringEncoding] forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Image methds

- (UIImage*)imageForKey:(NSString*)key {
	return [UIImage imageWithData:[self dataForKey:key]];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key {
	[self setImage:anImage forKey:key withTimeoutInterval:self.defaultCacheExpireInterval];
}

- (void)setImage:(UIImage*)anImage forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval {
	[self setData:UIImagePNGRepresentation(anImage) forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Property List methods

- (NSData*)plistForKey:(NSString*)key; {  
	NSData* plistData = [self dataForKey:key];
	
	return [NSPropertyListSerialization propertyListFromData:plistData
																					mutabilityOption:NSPropertyListImmutable
																										format:nil
																					errorDescription:nil];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key; {
	[self setPlist:plistObject forKey:key withTimeoutInterval:self.defaultCacheExpireInterval];
}

- (void)setPlist:(id)plistObject forKey:(NSString*)key withTimeoutInterval:(NSTimeInterval)timeoutInterval; {

	NSData* plistData = [NSPropertyListSerialization dataFromPropertyList:plistObject 
																   format:NSPropertyListBinaryFormat_v1_0
														 errorDescription:NULL];
	
	[self setData:plistData forKey:key withTimeoutInterval:timeoutInterval];
}

#pragma mark -
#pragma mark Disk writing operations

- (void)performDiskWriteOperation:(NSInvocation *)invoction {
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invoction];
	[operationQueue addOperation:operation];
	[operation release];
}

#pragma mark -

+(NSString *) cacheDirectory{
	if(!cacheDirectory) {
		NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		cacheDirectory = [[[cachesDirectory stringByAppendingPathComponent:
												[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"JACacheAssets"] 
											copy];
	}
	
	return cacheDirectory;
}

+(NSString *) keyForURL:(NSURL *)url {
	return [NSString stringWithFormat:@"JACache-%u", [[url description] hash]];
}

#pragma mark -

- (void)dealloc {
	[operationQueue release];
	[caches release];
	[super dealloc];
}

@end