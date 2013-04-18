//
//  StateCell.m
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StateCell.h"

@implementation StateCell

+ (StateCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    StateCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[StateCell class]]) {
            xibBasedCell = (StateCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}

-(void) dealloc{

	[super dealloc];
}

@end
