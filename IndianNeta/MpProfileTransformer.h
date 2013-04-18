//
//  MpProfileTransformer.h
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MpProfile.h"
#import "Transformer.h"

@interface MpProfileTransformer : NSObject <Transformer, NSXMLParserDelegate> {
    
    NSString *_text;
    MpProfile *_profile;
    BOOL constituencyName;
    BOOL partyName;
    BOOL email;
    BOOL name;

}

@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) MpProfile *profile;
@property(assign) BOOL constituencyName;
@property(assign) BOOL partyName;
@property(assign) BOOL email;
@property(assign) BOOL name;
@end
