//
//  MpProfileDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpProfileDataSource.h"
#import "MpProfileTransformer.h"

@implementation MpProfileDataSource

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
	return [NSString stringWithFormat:@"constituencies/%d/mp.xml",UserParameterValueForKey(@"constituencyId")];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
