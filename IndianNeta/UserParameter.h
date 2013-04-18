//
//  UserParameter.h
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserParameter : NSObject{

    NSInteger stateId;
    NSInteger partyId;
    NSInteger mpId;
    NSInteger constituencyId;


}

@property(assign) NSInteger stateId;
@property(assign) NSInteger partyId;
@property(assign) NSInteger mpId;
@property(assign) NSInteger constituencyId;

+ (UserParameter *) sharedInstance;

NSInteger UserParameterValueForKey(NSString *key);
id UserParameterObjectForKey(NSString *key);
void SetUserParameterValueForKey(NSString *key, NSInteger value);
void SetUserParameterObjectForKey(NSString *key, id value);

@end
