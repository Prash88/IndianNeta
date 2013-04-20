//
//  StatesViewController.h
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADMasterViewController.h"

@interface StatesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_statesArray;
    UITableView *_tableView;

}
@property (nonatomic,retain) NSMutableArray *statesArray;
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
