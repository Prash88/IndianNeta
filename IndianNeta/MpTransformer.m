//
//  MpTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpTransformer.h"
#import "Mps.h"
#import "ASIHTTPRequest.h"

@implementation MpTransformer

@synthesize mp = _mp, text = _text, mps = _mps, name;

-(id)init
{
	if(self = [super init]){
		self.mps = [[[NSMutableArray alloc] init] autorelease];
        self.text = @"";
        self.mp = nil;
        name = false;
	}
	return self;
}


- (id)transform:(ASIHTTPRequest *)request
{
	NSData *response = [request responseData];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:response];
	[parser setDelegate:self];
	[parser parse];
	[parser release];
	return self.mps;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"mp"]){
        
        name = true;
        Mps *mp = [[Mps alloc] init];
        self.mp = mp;
        [mp release];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
    
    if([elementName isEqualToString:@"id"] && name){
        [self.mp setMpId:[self.text intValue]];
	}
    
	if([elementName isEqualToString:@"name"] && name){
		
        [self.mp setName:self.text];
        name = false;
        if (self.mp != nil) {
            [self.mps addObject:self.mp];
            self.mp = nil;
        }
    }
	
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_mp release], _mp = nil;
    [_mps release], _mps = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
