//
//  StatesTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformer.h"
@class State;

@interface StatesTransformer : NSObject<Transformer, NSXMLParserDelegate>{
    NSMutableArray *_states;
    NSString *_text;
    State *_state;
}

@property(nonatomic, retain) NSMutableArray *states;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) State *state;

@end
