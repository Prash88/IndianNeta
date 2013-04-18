//
//  StatesDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 1/16/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StatesDataSource.h"
#import "StatesTransformer.h"

@implementation StatesDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [StatesTransformer class];
}

-(NSString *) path{
	return @"/states.xml";
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
