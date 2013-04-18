//
//  Mp.h
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mp : NSObject{
    
    NSString *_name;
    NSString *_party;
    NSString *_constituency;
    NSInteger constituencyId;

}

@property(assign) NSInteger constituencyId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *constituency;
@property(nonatomic, retain) NSString *party;

@end
