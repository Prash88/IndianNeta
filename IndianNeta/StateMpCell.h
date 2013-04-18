//
//  StateMpCell.h
//  IndianNeta
//
//  Created by Prashanth on 3/30/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StateMpCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *name;
@property (nonatomic,assign) IBOutlet UILabel *party;
@property (nonatomic,assign) IBOutlet UILabel *constituency;

+ (StateMpCell *)cellFromNibNamed:(NSString *)nibName;

@end
