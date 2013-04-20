//
//  ConstituencyTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "ConstituencyTransformer.h"
#import "Constituency.h"
#import "ASIHTTPRequest.h"

@implementation ConstituencyTransformer

@synthesize constituency = _constituency, text = _text, constituencies = _constituencies, name;

-(id)init
{
	if(self = [super init]){
		self.constituencies = [[[NSMutableArray alloc] init] autorelease];
        self.text = @"";
        self.constituency = nil;
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
	return self.constituencies;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"constituency"]){
                name = true;
        Constituency *constituency = [[Constituency alloc] init];
        self.constituency = constituency;
        [constituency release];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
    
    if([elementName isEqualToString:@"id"] && name){
        [self.constituency setConstituencyId:[self.text intValue]];
	}
    
	if([elementName isEqualToString:@"name"] && name){
		
        [self.constituency setName:self.text];
        if (self.constituency != nil) {
            [self.constituencies addObject:self.constituency];
            self.constituency = nil;
        }
        name = false;
    }
	
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_constituency release], _constituency = nil;
    [_constituencies release], _constituencies = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
