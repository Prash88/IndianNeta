//
//  ConstituencyDataSource.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "ConstituencyDataSource.h"
#import "ConstituencyTransformer.h"

@implementation ConstituencyDataSource

-(BOOL) isJSON{
	return FALSE;
}

-(NSString *) serviceForDataSource{
	return @"NetaService";
}

-(Class) transformerForDataSource{
	return [ConstituencyTransformer class];
}

-(NSString *) path{
	return [NSString stringWithFormat:@"constituencies.xml"];
}

-(RequestMethod) requestMethod{
    
	return GET;
    
}

@end
