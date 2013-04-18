//
//  Service.h
//  IndianNeta
//
//  Created by Prashanth on 1/15/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_ENVIRONEMNT   @"production"
#define PROD_ENVIRONEMNT	  @"production"
#define DEV_ENVIRONEMNT		  @"development"
#define SERVICE_CONFIG        @"Services.plist"
#define SERVICE_URL           @"url"
#define SERVICE_CONTEXT_PATH  @"contextPath"

@interface Service : NSObject {
	NSMutableDictionary *_services;
}

@property(nonatomic, retain) NSMutableDictionary *services;

+ (Service *) sharedInstance;
- (NSString *) serviceURLForDataSource:(NSString *)ds;

@end

