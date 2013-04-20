//
//  StateMpViewController.h
//  IndianNeta
//
//  Created by Prashanth on 3/30/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GADMasterViewController.h"

@interface StateMpViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *_stateMpArray;
    UITableView *_tableView;
}
@property (nonatomic,retain) NSMutableArray *stateMpArray;
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@end
