//
//  Environment.h
//  Ask
//
//  Created by askqe on 1/19/11.
//  Copyright 2011 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Environment : NSObject {

}

+ (NSString *)currentEnvironment;

+ (BOOL) isDevEnvironment;

+ (BOOL) isProdEnvironment;

+ (void) cleanUp;

@end
