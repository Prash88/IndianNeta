//
//  Datasource.m
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

@synthesize delegate = _delegate;

-(id) initWithDelegate:(id)delegate{
	if(self = [super init]){
		self.delegate = delegate;
	}
	
	return self;
}

-(id) initWithDataSource:(DataSource *)datasource{
	if(self = [super init]){
		self.delegate = datasource.delegate;
	}
	
	return self;
}

-(BOOL)shouldValidateErrorForResponse{
	return YES;
}

-(void)main{
    
}

-(void)dealloc{
	NSLog(@"DSC: %@ Killed!!", [self class]);
	[super dealloc];
}

@end