//
//  AnotherMpProfileDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/18/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "AnotherMpProfileDataSource.h"
#import "MpProfileTransformer.h"

@implementation AnotherMpProfileDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [MpProfileTransformer class];
}

-(NSString *) path{
	return [NSString stringWithFormat:@"mps/%d.xml",UserParameterValueForKey(@"mpId")];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end