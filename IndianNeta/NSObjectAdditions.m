//
//  NSObjectAdditions.m
//  Ask
//
//  Created by Vasanth on 7/27/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "NSObjectAdditions.h"

@implementation NSObject (JAAdditions)

- (void) dispatchSelector:(SEL)selector
									 target:(id)target
									objects:(NSArray*)objects
						 onMainThread:(BOOL)onMainThread {
	
	if(target && [target respondsToSelector:selector]) {
		NSMethodSignature* signature
		= [target methodSignatureForSelector:selector];
		if(signature) {
	    NSInvocation* invocation
			= [NSInvocation invocationWithMethodSignature:signature];
			
			@try {
				[invocation setTarget:target];
				[invocation setSelector:selector];
				
				if(objects) {
					NSInteger objectsCount	= [objects count];
					
					for(NSInteger i=0; i < objectsCount; i++) {
		        NSObject* obj = [objects objectAtIndex:i];
						[invocation setArgument:&obj atIndex:i+2];
					}
				}
				
				[invocation retainArguments];
				
				if(onMainThread) {
					[invocation performSelectorOnMainThread:@selector(invoke)
																			 withObject:nil
																		waitUntilDone:NO];
				}
				else {
					[invocation performSelector:@selector(invoke)
														 onThread:[NSThread currentThread]
													 withObject:nil
												waitUntilDone:NO];
				}
	    }
	    @catch (NSException * e) {

	    }
		}
	}
}


@end
