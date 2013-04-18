//
//  ConstituencyCell.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "ConstituencyCell.h"

@implementation ConstituencyCell

+ (ConstituencyCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    ConstituencyCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[ConstituencyCell class]]) {
            xibBasedCell = (ConstituencyCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}


-(void) dealloc{
    
	[super dealloc];
}


@end
