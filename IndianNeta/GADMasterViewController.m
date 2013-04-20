//
//  GADMasterViewController.m
//  IndianNeta
//
//  Created by Prashanth on 4/19/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "GADMasterViewController.h"

#define ADMOB_KEY @"a15171f34eb6692"

@implementation GADMasterViewController


+(GADMasterViewController *)singleton {
    static dispatch_once_t pred;
    static GADMasterViewController *shared;
    // Will only be run once, the first time this is called
    dispatch_once(&pred, ^{
        shared = [[GADMasterViewController alloc] init];
    });
    return shared;
}

-(id)init {
    if (self = [super init]) {
        adBanner_ = [[GADBannerView alloc]
                     initWithFrame:CGRectMake(0.0,
                                              317.0,
                                              GAD_SIZE_320x50.width,
                                              GAD_SIZE_320x50.height)];
        // Has an ad request already been made
        isLoaded_ = NO;
    }
    return self;
}

-(void)resetAdView:(UIViewController *)rootViewController {
    // Always keep track of currentDelegate for notification forwarding
    currentDelegate_ = rootViewController;
    
    // Ad already requested, simply add it into the view
    if (isLoaded_) {
        [rootViewController.view addSubview:adBanner_];
    } else {
        
        adBanner_.delegate = self;
        adBanner_.rootViewController = rootViewController;
        adBanner_.adUnitID = ADMOB_KEY;
        
        GADRequest *request = [GADRequest request];
        //Test ads...
        request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID, nil];
        
        [adBanner_ loadRequest:request];
        [rootViewController.view addSubview:adBanner_];
        isLoaded_ = YES;
    }
}


#pragma mark -
#pragma mark MyBanner Callbacks

- (void)adViewDidReceiveAd:(GADBannerView *)view {

    
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {


}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {


}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {


}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {


}


@end
