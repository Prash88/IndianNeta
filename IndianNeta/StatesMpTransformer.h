//
//  StatesMpTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformer.h"
#import "Mp.h"
@class State;

@interface StatesMpTransformer : NSObject<Transformer, NSXMLParserDelegate>{
    NSMutableArray *_statesMps;
    NSString *_text;
    Mp *_stateMp;
    BOOL mp;
    BOOL name;
    BOOL constituency;
}

@property(nonatomic, retain) NSMutableArray *statesMps;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) Mp *stateMp;
@property(nonatomic, assign) BOOL mp;
@property(nonatomic, assign) BOOL name;
@property(nonatomic, assign) BOOL constituency;

@end
