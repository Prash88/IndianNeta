//
//  PartyTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformer.h"

@class Party;

@interface PartyTransformer : NSObject <Transformer, NSXMLParserDelegate> {
  
    NSMutableArray *_parties;
    NSString *_text;
    Party *_party;
    BOOL name;
    
}

@property(nonatomic, retain) NSMutableArray *parties;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) Party *party;
@property(nonatomic, assign) BOOL name;

@end

