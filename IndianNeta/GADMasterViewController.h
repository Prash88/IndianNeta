//
//  GADMasterViewController.h
//  IndianNeta
//
//  Created by Prashanth on 4/19/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"

@class GADBannerView, GADRequest;
@interface GADMasterViewController : UIViewController <GADBannerViewDelegate>{
    
    GADBannerView *adBanner_;
    BOOL didCloseWebsiteView_;
    BOOL isLoaded_;
    id currentDelegate_;
}

+(GADMasterViewController *)singleton;
-(void)resetAdView:(UIViewController *)rootViewController;
@end
