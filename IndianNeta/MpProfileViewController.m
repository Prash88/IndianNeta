//
//  MpProfileViewController.m
//  IndianNeta
//
//  Created by Prashanth on 4/13/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpProfileViewController.h"
#import "MpProfileDataSource.h"
#import "Reachability.h"
#import "BusinessLogic.h"
#import "GlobalUI.h"
#import "UserParameter.h"

@implementation MpProfileViewController

@synthesize mpProfile = _mpProfile;

- (void)enteredForeground{
    
    
    if (self.mpProfile != NULL) {
        
        [self.image setImageURL:[self.mpProfile profilePic]];
        
        [self.name setText:[self.mpProfile name]];
        [self.constituency setText:[self.mpProfile constituency]];
        [self.party setText:[self.mpProfile party]];
        [self.address setText:[[self.mpProfile address] ampersandDecode]];
        [self.email setText:[self.mpProfile email]];
        
    }
    
    if (self.view.hidden == TRUE) {
        
        [self.view setHidden:FALSE];
        [MpProfileDataSource triggerRequestWithDelegate:self];
        
    }

}

- (void)enteredBackground{
    
    for(UIView *subview in [self.view subviews]) {
        if([subview isKindOfClass:[GADBannerView class]]) {
            [subview removeFromSuperview];
        }
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:NO];
    
    for(UIView *subview in [self.view subviews]) {
        if([subview isKindOfClass:[GADBannerView class]]) {
            [subview removeFromSuperview];
        }
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [[GADMasterViewController singleton] resetAdView:self];
    
    if (self.mpProfile != NULL) {
        
        [self.image setImageURL:[self.mpProfile profilePic]];
        
        [self.name setText:[self.mpProfile name]];
        [self.constituency setText:[self.mpProfile constituency]];
        [self.party setText:[self.mpProfile party]];
        [self.address setText:[[self.mpProfile address] ampersandDecode]];
        [self.email setText:[self.mpProfile email]];

    }
    
    if (self.view.hidden == TRUE) {
    
        [self.view setHidden:FALSE];
        [MpProfileDataSource triggerRequestWithDelegate:self];
    
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setHidden:FALSE];
    [MpProfileDataSource triggerRequestWithDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredForeground)
                                                 name: @"didEnterForeground"
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(enteredBackground)
                                                 name: @"didEnterBackground"
                                               object: nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Datasource delegate

- (void)requestFinished:(ASIHTTPRequest *)request product:(id)product{
    
    NetworkRequestStopped();
    
    Class dsClass = [[request userInfo] objectForKey:@"dsClass"];
	NSString *dataSourceClass = NSStringFromClass(dsClass);
    
	if([dataSourceClass isEqualToString:NSStringFromClass([MpProfileDataSource class])]){
        
        if ([product isKindOfClass:[MpProfile class]]) {
            
            self.mpProfile = product;
            [self viewWillAppear:NO];
            

        }
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
	Reachability* reachability = [Reachability reachabilityForInternetConnection];
	if (![reachability currentReachabilityStatus] && ([request.error code] == 1)) {
        [self.view setHidden:TRUE];
		JAAlert(@"Error", @"This app requires an internet connection.Please check your internet connection.");
	}
    else if ([request.error code] == 2) {
        [self.view setHidden:TRUE];
        JAAlert(@"Error", @"Oops! Looks like the system timed out. Please try again now or come back in a few minutes.");
	}
}

#pragma mark - Dealloc

-(void)dealloc{
	NSLog(@"Class : %@ Killed!!", [self class]);
    [_mpProfile release], _mpProfile = nil;
	[super dealloc];
}

@end
