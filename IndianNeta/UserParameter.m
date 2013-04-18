//
//  UserParameter.m
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "UserParameter.h"
#import "SynthesizeSingleton.h"

@implementation UserParameter

@synthesize stateId;

SYNTHESIZE_SINGLETON_FOR_CLASS(UserParameter);


- (id)init{
	if(self = [super init]){
        
	}
	
	return self;
}


NSInteger UserParameterValueForKey(NSString *key){
	return [[[UserParameter sharedInstance] valueForKey:key] integerValue];
}

id UserParameterObjectForKey(NSString *key){
	return [[UserParameter sharedInstance] valueForKey:key];
}

void SetUserParameterValueForKey(NSString *key, NSInteger value){
	[[UserParameter sharedInstance] setValue:[NSNumber numberWithInt:value] forKey:key];
}

void SetUserParameterObjectForKey(NSString *key, id value){
	[[UserParameter sharedInstance] setValue:value forKey:key];
}

@end

