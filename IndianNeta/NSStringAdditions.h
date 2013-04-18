//
//  NSStringAdditions.h
//  AnswerPsychic
//
//  Created by Vasanth on 3/5/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additions)

- (BOOL)isWhitespaceAndNewlines;
- (BOOL)isEmptyOrWhitespace;
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;
- (NSDate *)dateWithFormat:(NSString *)format;
- (NSDate *)dateWithDefaultFormat;
- (NSString *)cleanupStringForWhiteSpace;
- (NSString *)cleanupStringForWhiteSpaceWithCarriageReturnAndTabs;
- (BOOL)hasURLContent;
- (NSString *)ampersandEncode;
- (NSString *)ampersandDecode;
- (NSString *)URLEncode;
- (NSString *)URLDecode;
- (NSString *)URLEncodeWithoutPercentEscapes;
- (NSString *)URLDecodeWithoutPercentEscapes;
@end


