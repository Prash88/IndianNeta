//
//  AppDelegate.h
//  IndianNeta
//
//  Created by Prashanth on 1/13/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#define SharedAdBannerView ((AppDelegate *) [[UIApplication sharedApplication] delegate]).adBanner

@interface AppDelegate : UIResponder <UIApplicationDelegate, ADBannerViewDelegate>{


}

@property (strong, nonatomic) UIWindow *window;

@end

