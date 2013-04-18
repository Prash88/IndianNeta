//
//  Environment.m
//  Ask
//
//  Created by askqe on 1/19/11.
//  Copyright 2011 Ask.com. All rights reserved.
//

#import "Environment.h"
#import "Service.h"

#define ENVIRONMENT_CONFIG    @"Environment.plist"
#define CURRENT_ENVIRONMENT		@"currentEnvironment"
#define ENVIRONMENTS					@"environments"
#define DEFAULT_ENVIRONMENT		@"default"

@implementation Environment

static NSMutableDictionary *_environmentConfig = nil;

+ (void) initialize{
	
	if(self == [Environment class] && _environmentConfig == nil){
		_environmentConfig = [[NSMutableDictionary dictionaryWithContentsOfFile:ResourcePath(ENVIRONMENT_CONFIG)] retain];
	}
}

+ (NSString *)currentEnvironment{

	NSString *currentEnvironment = @"";
	NSString *currentEnvironmentName = [_environmentConfig objectForKey:CURRENT_ENVIRONMENT];
	NSDictionary *environments = [_environmentConfig objectForKey:ENVIRONMENTS];
	
	if(!IsEmptyString(currentEnvironmentName)){
		currentEnvironment = [environments objectForKey:currentEnvironmentName];
	} else {
		currentEnvironment = [environments objectForKey:DEFAULT_ENVIRONMENT];
	}
	
	return currentEnvironment;
}

+ (BOOL) isDevEnvironment{
	
	return ([[Environment currentEnvironment] isEqualToString:DEV_ENVIRONEMNT]);
}

+ (BOOL) isProdEnvironment{
						
	return ([[Environment currentEnvironment] isEqualToString:PROD_ENVIRONEMNT]);
}

+ (void)cleanUp{
	[_environmentConfig release];
}

@end
