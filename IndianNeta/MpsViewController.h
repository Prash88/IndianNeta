//
//  MpsViewController.h
//  IndianNeta
//
//  Created by Prashanth on 3/31/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADMasterViewController.h"

@interface MpsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    
    NSMutableArray *_mpsArray;
    UITableView *_tableView;


}

@property (nonatomic,retain) NSMutableArray *mpsArray;
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
