//
//  Mp.m
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "Mp.h"

@implementation Mp
@synthesize name = _name, party = _party, constituency = _constituency, constituencyId;

-(void) dealloc{
    
    [_name release], _name = nil;
    [_party release], _party = nil;
    [_constituency release], _constituency = nil;
	[super dealloc];
}

@end