//
//  StatesMpTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 3/25/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StatesMpTransformer.h"
#import "Mp.h"
#import "ASIHTTPRequest.h"

@implementation StatesMpTransformer

@synthesize statesMps = _statesMps, text = _text, stateMp = _stateMp, mp, name, constituency;

-(id)init
{
	if(self = [super init]){
		self.statesMps = [[[NSMutableArray alloc] init] autorelease];
        self.text = nil;
        self.stateMp = nil;
        mp = false;
        name = false;
        constituency = false;
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
	return self.statesMps;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"mp"]){
        
        mp = true;
        Mp *mpObj = [[Mp alloc] init];
        self.stateMp = mpObj;
        [mpObj release];
        
    }
    
    if([elementName isEqualToString:@"party"]){

        name = true;

    }
    
    if([elementName isEqualToString:@"constituency"]){
        
        constituency = true;

    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
	
	if([elementName isEqualToString:@"name"] && mp){
		
        [self.stateMp setName:self.text];
        mp = false;
        
    }
	
    if([elementName isEqualToString:@"name"] && name){
		
        [self.stateMp setParty:self.text];
        name = false;
        
    }
    
    if([elementName isEqualToString:@"id"] && constituency){
		
        [self.stateMp setConstituencyId:[self.text intValue]];
        
    }
    
    if([elementName isEqualToString:@"name"] && constituency){
		
        [self.stateMp setConstituency:self.text];
        constituency = false;
        
        if (self.stateMp != nil) {
            [self.statesMps addObject:self.stateMp];
            self.stateMp = nil;
        }
        
    }
    
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_statesMps release], _statesMps = nil;
    [_stateMp release], _stateMp = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
