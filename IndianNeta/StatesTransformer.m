//
//  StatesTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 3/22/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "StatesTransformer.h"
#import "State.h"
#import "ASIHTTPRequest.h"

@implementation StatesTransformer

@synthesize states = _states, text = _text, state = _state;

-(id)init
{
	if(self = [super init]){
		self.states = [[[NSMutableArray alloc] init] autorelease];
        self.text = @"";
        self.state = nil;
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
	return self.states;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
        if([elementName isEqualToString:@"state"]){
            
            State *state = [[State alloc] init];
            self.state = state;
            [state release];
            
        }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
	
	if([elementName isEqualToString:@"name"]){
		
        [self.state setName:self.text];
    
    }
	
	if([elementName isEqualToString:@"id"]){
        
        [self.state setSId:[self.text intValue]];
		
	}
	
	if([elementName isEqualToString:@"no_of_mps"]){
        
        [self.state setNoOfMps:[self.text intValue]];
	}
	
    if([elementName isEqualToString:@"state"]){
        
        if (self.state != nil) {
            [self.states addObject:self.state];
            self.state = nil;
        }

	}
    
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_state release], _state = nil;
    [_states release], _states = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
