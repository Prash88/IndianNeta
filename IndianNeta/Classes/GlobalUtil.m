#import "GlobalUtil.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h> 

NSString* UUID(){
	return [[UIDevice currentDevice] uniqueIdentifier];
}

void SetUserDefaultsForKey(NSString *key, id value){
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	if([value isKindOfClass:[NSString class]]){
		[defaults setValue:value forKey:key];	
	}else{
		[defaults setObject:value forKey:key];	
	}
	
	[defaults synchronize];
}

void SetIntegerUserDefaultsForKey(NSString *key, NSInteger value){
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setInteger:value forKey:key];
	
	[defaults synchronize];
}

NSString* StringFromUserDefaultsForKey(NSString *key){
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults stringForKey:key];
}

NSInteger IntegerFromUserDefaultsForKey(NSString *key){
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults integerForKey:key];
}

id ObjectFromUserDefaultsForKey(NSString *key){
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:key];
}

void ArchiveObjectForKey(NSString *key, id value){
	SetUserDefaultsForKey(key, [NSKeyedArchiver archivedDataWithRootObject:value]);
}

id UnArchiveObjectForKey(NSString *key){
	if (ObjectFromUserDefaultsForKey(key) == NULL) {
		return nil;
	}
	return [NSKeyedUnarchiver unarchiveObjectWithData:ObjectFromUserDefaultsForKey(key)];
}

BOOL IsArrayWithItems(id object) {
	return [object isKindOfClass:[NSArray class]] && [(NSArray*)object count] > 0;
}

BOOL IsArrayWithItemsMoreThanCount(id object, int count) {
	return [object isKindOfClass:[NSArray class]] && ([(NSArray*)object count] > count);
}

BOOL IsEmptyString(id object){
	return (object == nil || [object isEqual:[NSNull null]] || ([object isKindOfClass:[NSString class]] && [(NSString*)object length] <= 0)); 
}

BOOL IsConnectedToNetwork()
{
	struct sockaddr_in zeroAddress;
	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;
	
	// Recover reachability flags
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags)
	{
		printf("Error. Could not recover network reachability flags\n");
		return 0;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	BOOL isWWAN = flags & kSCNetworkReachabilityFlagsIsWWAN;
	return ((isReachable || isWWAN) && !needsConnection) ? YES : NO;
}

BOOL isOS3Plus(){
	if([[[UIDevice currentDevice]  systemVersion] floatValue] >= 3.0){
		return TRUE;
	}
	return FALSE;	   
}

NSString* CachePath(NSString* path){
	NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString * cacheDirectory = [[paths objectAtIndex:0]retain];
	NSString * cachePath = [cacheDirectory stringByAppendingPathComponent:path];
	[cacheDirectory release];
	return cachePath;	
}

