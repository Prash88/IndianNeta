//
//  Transformer.h
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol Transformer<NSObject>

- (id)transform:(ASIHTTPRequest *)request;

@end

