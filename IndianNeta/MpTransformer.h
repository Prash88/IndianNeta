//
//  MpTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transformer.h"
@class Mps;

@interface MpTransformer : NSObject<Transformer, NSXMLParserDelegate>{
    NSMutableArray *_mps;
    NSString *_text;
    Mps *_mp;
    BOOL name;

}

@property(nonatomic, retain) NSMutableArray *mps;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain)  Mps *mp;
@property(nonatomic, assign) BOOL name;

@end
