//
//  Service.m
//  IndianNeta
//
//  Created by Prashanth on 1/15/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "Service.h"
#import "SynthesizeSingleton.h"
#import "Environment.h"
#import "GlobalUI.h"

@implementation Service

SYNTHESIZE_SINGLETON_FOR_CLASS(Service);

@synthesize services = _services;

- (id) init{
	
	if(self = [super init]){
		self.services = [NSMutableDictionary dictionaryWithContentsOfFile:ResourcePath(SERVICE_CONFIG)];
	}
	
	return self;
}

- (NSString *) serviceURLForDataSource:(NSString *)ds{
	
	NSString *currentEnvironment = [Environment currentEnvironment];
	
	NSDictionary *devServices = [self.services objectForKey:currentEnvironment];
	NSDictionary *serviceConfig	= [devServices objectForKey:ds];
	NSString *datasourceURL = [serviceConfig objectForKey:SERVICE_URL];
	NSString *contextPath = [serviceConfig objectForKey:SERVICE_CONTEXT_PATH];
	if(![contextPath isEmptyOrWhitespace]){
		NSString *foramt = [contextPath hasPrefix:@"/"] ? @"%@" : @"/%@";
		datasourceURL = [datasourceURL stringByAppendingFormat:foramt, contextPath];
	}
	if([datasourceURL isEmptyOrWhitespace]){
		[NSException exceptionWithName:@"JAServiceURLUndefined"
								reason:[NSString stringWithFormat:@"Service URL for %@ is Undefined", ds]
							  userInfo:nil];
	}
	
	return datasourceURL;
}

@end