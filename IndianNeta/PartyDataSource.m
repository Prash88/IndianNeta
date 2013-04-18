//
//  PartyDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "PartyDataSource.h"
#import "PartyTransformer.h"

@implementation PartyDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [PartyTransformer class];
}

-(NSString *) path{
	return [NSString stringWithFormat:@"/mps.xml"];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
