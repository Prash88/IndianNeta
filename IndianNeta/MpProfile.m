
//
//  MpProfile.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpProfile.h"

@implementation MpProfile

@synthesize name = _name, party = _party, constituency = _constituency;
@synthesize email = _email;
@synthesize profilePic = _profilePic;

-(void) dealloc{
    
    [_name release], _name = nil;
    [_party release], _party = nil;
    [_constituency release], _constituency = nil;
    [_email release], _email = nil;
    [_profilePic release], _profilePic = nil;
	[super dealloc];
}

@end