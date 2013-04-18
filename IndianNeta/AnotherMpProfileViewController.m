//
//  AnotherMpProfileViewController.m
//  IndianNeta
//
//  Created by Prashanth on 4/17/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "AnotherMpProfileViewController.h"
#import "AnotherMpProfileDataSource.h"
#import "Reachability.h"
#import "BusinessLogic.h"
#import "GlobalUI.h"
#import "UserParameter.h"

@implementation AnotherMpProfileViewController

@synthesize mpProfile = _mpProfile;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    if (self.mpProfile != NULL) {
        
        [self.image setImageURL:[self.mpProfile profilePic]];
        
        [self.name setText:[self.mpProfile name]];
        [self.constituency setText:[self.mpProfile constituency]];
        [self.party setText:[self.mpProfile party]];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [AnotherMpProfileDataSource triggerRequestWithDelegate:self];
    
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
    
	if([dataSourceClass isEqualToString:NSStringFromClass([AnotherMpProfileDataSource class])]){
        
        if ([product isKindOfClass:[MpProfile class]]) {
            
            self.mpProfile = product;
            [self viewWillAppear:NO];
            
            
        }
        
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request{
	Reachability* reachability = [Reachability reachabilityForInternetConnection];
	if (![reachability currentReachabilityStatus] && ([request.error code] == 1)) {
		JAAlert(@"Error", @"This app requires an internet connection.Please check your internet connection.");
	}
    else if ([request.error code] == 2) {
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