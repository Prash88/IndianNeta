//
//  NSStringAdditions.m
//  AnswerPsychic
//
//  Created by Vasanth on 3/5/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "RegexKitLite.h"

@implementation NSString (Additions)

- (BOOL)isWhitespaceAndNewlines {
	NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	for (NSInteger i = 0; i < self.length; ++i) {
		unichar c = [self characterAtIndex:i];
		if (![whitespace characterIsMember:c]) {
			return NO;
		}
	}
	return YES;
}

- (BOOL)isEmptyOrWhitespace {
	return !self.length || 
	![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

-(BOOL)isEmpty{
	return ((nil == self) || ([self length] <= 0));
}

- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
	NSMutableArray* pairs = [NSMutableArray array];
	for (NSString* key in [query keyEnumerator]) {
		NSString* value = [query objectForKey:key];
		value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
		value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
		NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
		[pairs addObject:pair];
	}
	
	NSString* params = [pairs componentsJoinedByString:@"&"];
	if ([self rangeOfString:@"?"].location == NSNotFound) {
		return [self stringByAppendingFormat:@"?%@", params];
	} else {
		return [self stringByAppendingFormat:@"&%@", params];
	}
}

-(NSDate *)dateWithFormat:(NSString *)format{
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setFormatterBehavior:NSDateFormatterBehavior10_4];
	[df setDateFormat:format];
	NSDate *convertedDate = [df dateFromString:self];
	[df release];
	
	return convertedDate;
}

-(NSDate *)dateWithDefaultFormat{
	
	NSDate *defaultFormatDate = nil;
	NSMutableString *dateStr = [[self mutableCopy] autorelease];
	
	@try {
    
    NSRange dotRange = [dateStr rangeOfRegex:@"\\..*-"];
    if (dotRange.length > 0) {
      
      dateStr = (NSMutableString *)[dateStr stringByReplacingCharactersInRange:dotRange 
                                                                    withString:@"-"];
    }
    
		[dateStr deleteCharacxtersInRange:NSMakeRange(22, 1)];
	}
	@catch (NSException * e) {
		NSLog(@"DateFormat Exception!");
	}
	
	defaultFormatDate = [dateStr dateWithFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
	
	return defaultFormatDate;
}

-(NSString *)URLEncode{
	NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																				  (CFStringRef)self,
																				  NULL,
																				  (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
																				  kCFStringEncodingUTF8 );
	return [encodedString autorelease];
}

-(NSString *)URLDecode{
	NSString *decodedString = (NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, (CFStringRef)@"%");
	return [decodedString autorelease];
}

-(NSString *)URLEncodeWithoutPercentEscapes{
	NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
																				  (CFStringRef)self,
																				  NULL,
																				  NULL,
																				  kCFStringEncodingUTF8 );
	return [encodedString autorelease];
}

-(NSString *)URLDecodeWithoutPercentEscapes{
	NSString *decodedString = (NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, (CFStringRef)@"");
	return [decodedString autorelease];
}

- (NSString *)cleanupStringForWhiteSpace{
	if(!IsEmptyString(self))
	{
		NSString *trimmedString = [self stringByReplacingOccurrencesOfRegex:@" +" withString:@" "];
		NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		return [trimmedString stringByTrimmingCharactersInSet:whitespaces];
	}  
	return nil;
}

- (NSString *)cleanupStringForWhiteSpaceWithCarriageReturnAndTabs{
	if(!IsEmptyString(self))
	{
		NSString *trimmedString = [self stringByReplacingOccurrencesOfRegex:@"\n+" withString:@""];
		trimmedString = [trimmedString stringByReplacingOccurrencesOfRegex:@"\t+" withString:@""];
		[trimmedString stringByReplacingOccurrencesOfRegex:@" +" withString:@" "];
		NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
		return [trimmedString stringByTrimmingCharactersInSet:whitespaces];
	}  
	return nil;
}

- (NSString *)ampersandEncode{
	if(!IsEmptyString(self)){
		
		NSString *ampersandEncode = [self stringByReplacingOccurrencesOfString:@"&" 
																	withString:@"amp;"];
		NSString *quotEncode = [ampersandEncode stringByReplacingOccurrencesOfString:@"\"" 
																		  withString:@"quot;"];	
		
		return [NSMutableString stringWithString:quotEncode];
	}
	return nil;
}

- (NSString *)ampersandDecode{
	if(!IsEmptyString(self)){
		NSString *removeAmpersand = [self stringByReplacingOccurrencesOfString:@"&amp;" 
																	withString:@"&"];
		NSString *removeQuot = [removeAmpersand stringByReplacingOccurrencesOfString:@"quot;" 
																	withString:@"\""];
		return [NSMutableString stringWithString:removeQuot];
	}
	return nil;
}

- (BOOL)hasURLContent{
	
	NSInteger stringIndex = 0;
	
	BOOL foundURL = FALSE;
	
	NSArray *URLPrefixs = [NSArray arrayWithObjects:@"http://", @"https://", @"www.", nil];
	
	NSRange searchRange = NSMakeRange(stringIndex, self.length - stringIndex);
	NSRange startRange;
	
	for (NSString *prefix in URLPrefixs) {
		startRange = [self rangeOfString:prefix options:NSCaseInsensitiveSearch
								   range:searchRange];
		if (startRange.location != NSNotFound) {
			foundURL = TRUE;			break;
		}
	}
	
	return foundURL;
}

@end


