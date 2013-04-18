//
//  MpCell.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpCell.h"

@implementation MpCell

+ (MpCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    MpCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[MpCell class]]) {
            xibBasedCell = (MpCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}


-(void) dealloc{
    
	[super dealloc];
}



@end
