//
//  Party.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Party : NSObject {
    
    NSString *_name;
    NSInteger partyId;

}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign) NSInteger partyId;

@end
