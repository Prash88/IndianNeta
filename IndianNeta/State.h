//
//  State.h
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject {
    NSInteger sId;
	NSInteger noOfMps;
    NSString *name;
}

@property(assign) NSInteger sId;
@property(assign) NSInteger noOfMps;
@property(nonatomic, retain) NSString *name;

@end
