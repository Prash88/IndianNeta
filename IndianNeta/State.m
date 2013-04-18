//
//  State.m
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "State.h"

@implementation State
@synthesize sId, noOfMps, name;

-(void) dealloc{
    [name release], name = nil;
	[super dealloc];
}

@end