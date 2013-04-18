//
//  PartyCell.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartyCell : UITableViewCell

@property (nonatomic,assign) IBOutlet UILabel *partyName;

+ (PartyCell *)cellFromNibNamed:(NSString *)nibName;

@end
