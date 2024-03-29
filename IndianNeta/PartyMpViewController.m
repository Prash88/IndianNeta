//
//  PartyMpViewController.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "PartyMpViewController.h"
#import "PartyMpDataSource.h"
#import "Mp.h"
#import "GlobalUI.h"
#import "UserParameter.h"
#import "StateMpCell.h"
#import "Reachability.h"
#import "BusinessLogic.h"

@implementation PartyMpViewController
@synthesize stateMpArray = _stateMpArray, tableView = _tableView;

- (void)enteredForeground{
    
    if (self.view.hidden == TRUE) {
        
        [self.view setHidden:FALSE];
        [PartyMpDataSource triggerRequestWithDelegate:self];
        
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
    
    if (self.view.hidden == TRUE) {
        
        [self.view setHidden:FALSE];
        [PartyMpDataSource triggerRequestWithDelegate:self];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setHidden:FALSE];
    [PartyMpDataSource triggerRequestWithDelegate:self];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.stateMpArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateMpCell *cell = nil;
    static NSString *cellIdentifier = @"StateMpCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = (StateMpCell *)[StateMpCell cellFromNibNamed:cellIdentifier];
        
    }
    // Configure the cell...
    [[cell name] setText:[[self.stateMpArray objectAtIndex:indexPath.row] name]];
    [[cell party] setText:[[self.stateMpArray objectAtIndex:indexPath.row] party]];
    [[cell constituency] setText:[[self.stateMpArray objectAtIndex:indexPath.row] constituency]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 115.0;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Mps";
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    for (int i = 0; i< [self.stateMpArray count]; i++) {
        
        //---Here you return the name i.e. Honda,Mazda and match the title for first letter of name and move to that row corresponding to that indexpath as below---//
        
        NSString *letterString = [[[self.stateMpArray objectAtIndex:i] constituency] substringToIndex:1];
        if ([letterString isEqualToString:title]) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
    return -1;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SetUserParameterValueForKey(@"constituencyId", [[self.stateMpArray objectAtIndex:indexPath.row] constituencyId]);
    [self performSegueWithIdentifier:@"third" sender:nil];
}

#pragma mark - Datasource delegate

- (void)requestFinished:(ASIHTTPRequest *)request product:(id)product{
    
    NetworkRequestStopped();
    
    Class dsClass = [[request userInfo] objectForKey:@"dsClass"];
	NSString *dataSourceClass = NSStringFromClass(dsClass);
    
	if([dataSourceClass isEqualToString:NSStringFromClass([PartyMpDataSource class])]){
        
        if ([product isKindOfClass:[NSArray class]]) {
            
            self.stateMpArray = product;
            [BusinessLogic sortArray:self.stateMpArray forKey:@"constituency" ascending:YES];
            
            if (self.tableView != nil) {
                [self.tableView reloadData];
            }
            
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


-(void)dealloc{
	NSLog(@"Class : %@ Killed!!", [self class]);
    [_stateMpArray release], _stateMpArray = nil;
    [_tableView release], _tableView = nil;
	[super dealloc];
}

@end
