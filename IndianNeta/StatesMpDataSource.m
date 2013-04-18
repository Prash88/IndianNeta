//
//  StatesMpDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StatesMpDataSource.h"
#import "StatesMpTransformer.h"

@implementation StatesMpDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [StatesMpTransformer class];
}

-(NSString *) path{
	return [NSString stringWithFormat:@"/states/%d/mps.xml",UserParameterValueForKey(@"stateId")];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
