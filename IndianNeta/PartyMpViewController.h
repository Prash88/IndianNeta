//
//  PartyMpViewController.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADMasterViewController.h"

@interface PartyMpViewController: UIViewController <UITableViewDelegate, UITableViewDataSource>{
   
    NSMutableArray *_stateMpArray;
    UITableView *_tableView;

}
@property (nonatomic,retain) NSMutableArray *stateMpArray;
@property (nonatomic,retain) IBOutlet UITableView *tableView;

@end
