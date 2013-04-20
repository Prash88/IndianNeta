//
//  MpProfile.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MpProfile : NSObject{
    
    NSString *_name;
    NSString *_party;
    NSString *_constituency;
    NSString *_address;
    NSString *_email;
    NSURL *_profilePic;
    
}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *party;
@property(nonatomic, retain) NSString *constituency;
@property(nonatomic, retain) NSString *address;
@property(nonatomic, retain) NSString *email;
@property(nonatomic, retain) NSURL *profilePic;
@end
