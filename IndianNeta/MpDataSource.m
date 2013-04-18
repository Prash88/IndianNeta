//
//  MpDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpDataSource.h"
#import "MpTransformer.h"

@implementation MpDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [MpTransformer class];
}

-(NSString *) path{
	return [NSString stringWithFormat:@"/mps.xml"];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
