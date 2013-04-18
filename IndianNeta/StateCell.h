//
//  StateCell.h
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StateCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *stateName;
@property (nonatomic,assign) IBOutlet UILabel *mps;

+ (StateCell *)cellFromNibNamed:(NSString *)nibName;

@end
