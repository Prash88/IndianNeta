//
//  BusinessLogic.m
//  IndianNeta
//
//  Created by Prashanth on 3/31/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "BusinessLogic.h"

@implementation BusinessLogic

+(void)sortArray:(NSMutableArray *)array forKey:(NSString *)key ascending:(BOOL)yesOrNo{
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key
																   ascending:yesOrNo
																	selector:@selector(caseInsensitiveCompare:)];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[array sortUsingDescriptors:sortDescriptors];
	[sortDescriptors release];
	[sortDescriptor release];
}


@end
