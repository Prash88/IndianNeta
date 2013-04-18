//
//  UIDevice+Hardware.h
//  Ask
//
//  Created by Askdev on 11/15/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IPHONE_SIMULATOR_NAMESTRING @"iPhone Simulator"
#define IPHONE_1G_NAMESTRING @"iPhone 1G"
#define IPHONE_3G_NAMESTRING @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING @"iPhone 3GS"
#define IPHONE_4G_NAMESTRING @"iPhone 4G"
#define IPHONE_UNKNOWN_NAMESTRING @"Unknown iPhone"
#define IPOD_1G_NAMESTRING @"iPod touch 1G"
#define IPOD_2G_NAMESTRING @"iPod touch 2G"
#define IPOD_3G_NAMESTRING @"iPod touch 3G"
#define IPOD_4G_NAMESTRING @"iPod touch 4G"
#define IPOD_UNKNOWN_NAMESTRING @"Unknown iPod"

typedef enum {
	UIDeviceUnknown,
	UIDeviceIphoneSimulator,
	UIDevice1GiPhone,
	UIDevice1GiPod,
	UIDevice3GiPhone,
	UIDevice3GSiPhone,
	UIDevice4GiPhone,
	UIDevice2GiPod,
	UIDevice3GiPod,
	UIDevice4GiPod,
	UIDeviceUnknowniPhone,
	UIDeviceUnknowniPod
} UIDevicePlatform;

enum {
	UIDeviceSupportsGPS	= 1 << 0,
	UIDeviceBuiltInSpeaker = 1 << 1,
	UIDeviceBuiltInCamera = 1 << 2,
	UIDeviceBuiltInMicrophone = 1 << 3,
	UIDeviceSupportsExternalMicrophone = 1 << 4,
	UIDeviceSupportsTelephony = 1 << 5,
	UIDeviceSupportsVibration = 1 << 6
};

@interface UIDevice (Hardware)
- (NSString *) platform;
- (int) platformType;
- (NSString *) platformString;
- (int) platformCapabilities;
- (BOOL) deviceHasBuiltInMic;
@end
