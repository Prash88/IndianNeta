//
//  Party.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "Party.h"

@implementation Party

@synthesize name = _name, partyId;

-(void) dealloc{
    
    [_name release], _name = nil;
    [super dealloc];

}

@end
