//
//  StateMpCell.m
//  IndianNeta
//
//  Created by Prashanth on 3/30/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StateMpCell.h"

@implementation StateMpCell

+ (StateMpCell *)cellFromNibNamed:(NSString *)nibName {
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    StateMpCell *xibBasedCell = nil;
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[StateMpCell class]]) {
            xibBasedCell = (StateMpCell *)nibItem;
            break; // we have a winner
        }
    }
    
    return xibBasedCell;
}

-(void) dealloc{
    
    [super dealloc];

}

@end
