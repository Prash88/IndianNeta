//
//  StatesViewController.m
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StatesViewController.h"
#import "StatesDataSource.h"
#import "State.h"
#import "StateCell.h"
#import "GlobalUI.h"
#import "UserParameter.h"
#import "StateMpViewController.h"
#import "BusinessLogic.h"
#import "Reachability.h"
#import "GADMasterViewController.h"

@implementation StatesViewController

@synthesize statesArray = _statesArray,  tableView = _tableView;

- (void)enteredForeground{
    
    if (self.view.hidden == TRUE) {
        
        [self.view setHidden:FALSE];
        [StatesDataSource triggerRequestWithDelegate:self];
        
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
        [StatesDataSource triggerRequestWithDelegate:self];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setHidden:FALSE];
    [StatesDataSource triggerRequestWithDelegate:self];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.statesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateCell *cell = nil;
    static NSString *cellIdentifier = @"StateCell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        
        cell = (StateCell *)[StateCell cellFromNibNamed:cellIdentifier];
    
    }
    // Configure the cell...
    [[cell stateName] setText:[[self.statesArray objectAtIndex:indexPath.row] name]];
    [[cell mps] setText:[NSString stringWithFormat:@"%d",[[self.statesArray objectAtIndex:indexPath.row] noOfMps]]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    for (int i = 0; i< [self.statesArray count]; i++) {
        
        //---Here you return the name i.e. Honda,Mazda and match the title for first letter of name and move to that row corresponding to that indexpath as below---//
        
        NSString *letterString = [[[self.statesArray objectAtIndex:i] name] substringToIndex:1];
        if ([letterString isEqualToString:title]) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        }
    }
    return -1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"States & Union Territories";
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SetUserParameterValueForKey(@"stateId", [[self.statesArray objectAtIndex:indexPath.row] sId]);
    [self performSegueWithIdentifier:@"first" sender:nil];

}

#pragma mark - Datasource delegate

- (void)requestFinished:(ASIHTTPRequest *)request product:(id)product{
    
    NetworkRequestStopped();

    Class dsClass = [[request userInfo] objectForKey:@"dsClass"];
	NSString *dataSourceClass = NSStringFromClass(dsClass);
    
	if([dataSourceClass isEqualToString:NSStringFromClass([StatesDataSource class])]){
 
        if ([product isKindOfClass:[NSArray class]]) {
        
            self.statesArray = product;
            [BusinessLogic sortArray:self.statesArray forKey:@"name" ascending:YES];

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

#pragma mark - Dealloc

-(void)dealloc{
	NSLog(@"Class : %@ Killed!!", [self class]);
    [_statesArray release], _statesArray = nil;
    [_tableView release], _tableView = nil;
	[super dealloc];
}

@end
