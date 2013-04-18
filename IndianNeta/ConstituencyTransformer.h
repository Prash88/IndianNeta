//
//  ConstituencyTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformer.h"
@class Constituency;

@interface ConstituencyTransformer : NSObject <Transformer, NSXMLParserDelegate> {
    
    NSMutableArray *_constituencies;
    NSString *_text;
    Constituency *_constituency;
    BOOL name;
    
}

@property(nonatomic, retain) NSMutableArray *constituencies;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) Constituency *constituency;
@property(nonatomic, assign) BOOL name;


@end
 