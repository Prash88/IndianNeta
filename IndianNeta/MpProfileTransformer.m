//
//  MpProfileTransformer.m
//  IndianNeta
//
//  Created by Prashanth on 4/1/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import "MpProfileTransformer.h"

@implementation MpProfileTransformer

@synthesize profile = _profile, text = _text, constituencyName, partyName, email, name;

-(id)init
{
	if(self = [super init]){
        self.text = @"";
        self.profile = nil;
        self.constituencyName = false;
        self.partyName = false;
        self.email = false;
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
	return self.profile;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"mp"]){
        
        name =TRUE;
        MpProfile *profile = [[MpProfile alloc] init];
        self.profile = profile;
        [profile release];
        
    }
    
    if([elementName isEqualToString:@"party"])
        partyName = TRUE;
    if([elementName isEqualToString:@"constituency"])
        constituencyName = TRUE;
    if([elementName isEqualToString:@"mp_profile"])
        email = TRUE;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
	self.text = (NSMutableString *)[[self.text stringByAppendingString:string] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	
	elementName = [elementName lowercaseString];
    
    if([elementName isEqualToString:@"name"] && name){
        [self.profile setName:self.text];
        name = false;
	}
    
    if([elementName isEqualToString:@"name"] && partyName){
        [self.profile setParty:self.text];
        partyName = false;
	}
	
    if([elementName isEqualToString:@"name"] && constituencyName){
        [self.profile setConstituency:self.text];
        constituencyName = false;
	}
    
    if([elementName isEqualToString:@"email"] && email){
        [self.profile setEmail:self.text];
	}
    
    if([elementName isEqualToString:@"photo"]){
        [self.profile setProfilePic:[NSURL URLWithString:self.text]];
        email = false;
	}
    
	self.text = (NSMutableString *)@"";
}

- (void)dealloc {
    [_profile release], _profile = nil;
    [_text release], _text = nil;
	[super dealloc];
}

@end
