
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
@synthesize address = _address;
@synthesize profilePic = _profilePic;
@synthesize email = _email;

-(void) dealloc{
    
    [_name release], _name = nil;
    [_party release], _party = nil;
    [_constituency release], _constituency = nil;
    [_address release], _address = nil;
    [_profilePic release], _profilePic = nil;
    [_email release], _email = nil;
	[super dealloc];
}

@end