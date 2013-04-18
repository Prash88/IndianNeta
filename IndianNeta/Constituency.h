//
//  Constituency.h
//  IndianNeta
//
//  Created by Prashanth on 3/31/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constituency : NSObject {
    
    NSString *_name;
    NSInteger constituencyId;

}

@property(nonatomic, retain) NSString *name;
@property(nonatomic, assign) NSInteger constituencyId;

@end
