//
//  MpCell.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MpCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *mpName;

+ (MpCell *)cellFromNibNamed:(NSString *)nibName;

@end