
//
//  PartyMpDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "PartyMpDataSource.h"
#import "StatesMpTransformer.h"

@implementation PartyMpDataSource

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
	return [NSString stringWithFormat:@"/parties/%d/mps.xml",UserParameterValueForKey(@"partyId")];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end

