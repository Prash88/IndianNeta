//
//  Constituency.m
//  IndianNeta
//
//  Created by Prashanth on 3/31/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "Constituency.h"

@implementation Constituency

@synthesize name = _name, constituencyId;

-(void) dealloc{
 
    [_name release], _name = nil;
    [super dealloc];

}

@end
