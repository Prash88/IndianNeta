//
//  ConstituencyCell.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstituencyCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *constituencyName;

+ (ConstituencyCell *)cellFromNibNamed:(NSString *)nibName;

@end
