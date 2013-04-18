//
//  PartyTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "PartyTransformer.h"
#import "Party.h"
#import "ASIHTTPRequest.h"
@implementation PartyTransformer

@synthesize party = _party, text = _text, parties = _parties, name;

-(id)init
{
	if(self = [super init]){
		self.parties = [[[NSMutableArray alloc] init] autorelease];
        self.text = @"";
        self.party = nil;
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
	return self.parties;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"party"]){
        
        name = true;
        Party *party = [[Party alloc] init];
        self.party = party;
        [party release];
        
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
    
    if([elementName isEqualToString:@"id"] && name){
        
        [self.party setPartyId:[self.text intValue]];
        name = false;
        if (self.party != nil) {
            [self.parties addObject:self.party];
            self.party = nil;
        }
        
	}
    
	if([elementName isEqualToString:@"name"] && name){
		
        [self.party setName:self.text];
    
    }
	
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_party release], _party = nil;
    [_parties release], _parties = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
