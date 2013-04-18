//
//  StateMpViewController.m
//  IndianNeta
//
//  Created by Prashanth on 3/30/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StateMpViewController.h"
#import "StatesMpDataSource.h"
#import "Mp.h"
#import "GlobalUI.h"
#import "UserParameter.h"
#import "StateMpCell.h"
#import "Reachability.h"
#import "BusinessLogic.h"

@implementation StateMpViewController
@synthesize stateMpArray = _stateMpArray;

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
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [StatesMpDataSource triggerRequestWithDelegate:self];
    
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
    
    return 150.0;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Constituencies";
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
    
	if([dataSourceClass isEqualToString:NSStringFromClass([StatesMpDataSource class])]){
        
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
		JAAlert(@"Error", @"This app requires an internet connection.Please check your internet connection.");
	}
    else if ([request.error code] == 2) {
        JAAlert(@"Error", @"Oops! Looks like the system timed out. Please try again now or come back in a few minutes.");
	}

}


-(void)dealloc{
	NSLog(@"Class : %@ Killed!!", [self class]);
    [_stateMpArray release], _stateMpArray = nil;
	[super dealloc];
}

@end
