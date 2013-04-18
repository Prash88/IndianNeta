//
//  NSObjectAdditions.h
//  Ask
//
//  Created by Vasanth on 7/27/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (JAAdditions)

- (void) dispatchSelector:(SEL)selector
									 target:(id)target
									objects:(NSArray*)objects
						 onMainThread:(BOOL)onMainThread;

@end
