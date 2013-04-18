//
//  UIDevice+Hardware.m
//  Ask
//
//  Created by Askdev on 11/15/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "UIDevice+hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G 
 iPhone2,1 -> iPhone 3GS 
 iPhone3,1 -> iPhone 4G 
 iPod1,1   -> iPod touch 1G 
 iPod2,1   -> iPod touch 2G 
 iPod3,1   -> iPod touch 3G 
 iPod4,1   -> iPod touch 4G 
 i386	   -> iPhone simulator 
 */

- (NSString *) platform
{
	size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithCString:machine encoding: NSUTF8StringEncoding];
	free(machine);
	return platform;
}

- (int) platformType
{
	NSString *platform = [self platform];
	if ([platform isEqualToString:@"iPhone1,1"]) return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"]) return UIDevice3GiPhone;
	if ([platform isEqualToString:@"iPhone2,1"]) return UIDevice3GSiPhone;
	if ([platform isEqualToString:@"iPhone3,1"]) return UIDevice4GiPhone;
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPod4,1"])   return UIDevice4GiPod;
	if ([platform isEqualToString:@"i386"])   return UIDeviceIphoneSimulator;
	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	return UIDeviceUnknown;
}

- (NSString *) platformString
{
	switch ([self platformType])
	{
		case UIDeviceIphoneSimulator: return IPHONE_SIMULATOR_NAMESTRING;
			
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
		case UIDevice4GiPhone: return IPHONE_4G_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
			
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice4GiPod: return IPOD_4G_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
			
		default: return nil;
	}
}

- (int) platformCapabilities
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDevice3GiPhone: return UIDeviceSupportsGPS | UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDeviceUnknowniPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
			
		case UIDevice1GiPod: return 0;
		case UIDevice2GiPod: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone;
		case UIDeviceUnknowniPod: return 0;
			
		default: return 0;
	}
}

- (BOOL) deviceHasBuiltInMic{
	switch ([self platformType])
	{
		case UIDeviceIphoneSimulator: return NO;
			
		case UIDevice1GiPhone: return YES;
		case UIDevice3GiPhone: return YES;
		case UIDevice3GSiPhone: return YES;
		case UIDevice4GiPhone: return YES;
		case UIDeviceUnknowniPhone: return NO;
			
		case UIDevice1GiPod: return NO;
		case UIDevice2GiPod: return NO;
		case UIDevice3GiPod: return NO;
		case UIDevice4GiPod: return YES;
		case UIDeviceUnknowniPod: return NO;
			
		default: return NO;
	}	
}

@end
