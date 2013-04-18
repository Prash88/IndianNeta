//
//  Mps.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "Mps.h"

@implementation Mps

@synthesize name = _name, mpId;

-(void) dealloc{
    
    [_name release], _name = nil;
    [super dealloc];

}

@end
