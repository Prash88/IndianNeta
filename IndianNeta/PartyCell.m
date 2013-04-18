//
//  PartyCell.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "PartyCell.h"

@implementation PartyCell

+ (PartyCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    PartyCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[PartyCell class]]) {
            xibBasedCell = (PartyCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}


-(void) dealloc{
    
	[super dealloc];
}


@end
