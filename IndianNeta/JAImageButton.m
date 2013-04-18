//
//  JAImageButton.h
//  JustAsk
//
//  Created by Vasanth on 01/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "JAImageButton.h"
#import "JACache.h"
#import "JAImageLoader.h"
#import "GlobalUI.h"
#import <QuartzCore/QuartzCore.h>

@implementation JAImageButton

@synthesize imageURL, placeholderImage, delegate, request = _request, link = _link;
@dynamic borderColor;

- (id) initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder] ) {
		[self addTarget:self action:@selector(imageClicked) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<JAImageButtonDelegate>)aDelegate {
	if((self = [super initWithFrame:CGRectZero])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
		[self addTarget:self action:@selector(imageClicked) forControlEvents:UIControlEventTouchUpInside];
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateNormal];
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateHighlighted];
	}
	
	return self;
}

- (void)setImageURL:(NSURL *)aURL {
	if(imageURL) {
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL) {
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateNormal];
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateHighlighted];
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}
  
  [[JAImageLoader sharedImageLoader] removeObserver:self];
  
	UIImage* anImage = [[JAImageLoader sharedImageLoader] imageForURL:aURL shouldLoadWithObserver:self];
	
	if(anImage) {
		[self setBackgroundImage:anImage forState:UIControlStateNormal];
		[self setBackgroundImage:anImage forState:UIControlStateHighlighted];
	} else {
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateNormal];
		[self setBackgroundImage:self.placeholderImage forState:UIControlStateHighlighted];
	}
}

-(void) setImageLink:(NSString *) linkString{
	_link = linkString;
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[JAImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[JAImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;

	UIImage* anImage = [[notification userInfo] objectForKey:@"image"];
	
	if(anImage){
		[self setBackgroundImage:anImage forState:UIControlStateNormal];
		[self setBackgroundImage:anImage forState:UIControlStateHighlighted];
		[self setNeedsDisplay];
	}
	
	if([self.delegate respondsToSelector:@selector(imageButtonLoadedImage:)]) {
		[self.delegate imageButtonLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	if([self.delegate respondsToSelector:@selector(imageButtonFailedToLoadImage:error:)]) {
		[self.delegate imageButtonFailedToLoadImage:self error:[[notification userInfo] 
																							objectForKey:@"error"]];
	}
}

- (void)setBorderColor:(NSString *)borderColor {
	
	if(!IsEmptyString(borderColor)){
		self.layer.borderColor = ColorWithHexString(borderColor).CGColor;
		self.layer.borderWidth = 2.0;
	} else {
		self.layer.borderWidth = 0.0;
	}

}

-(void) imageClicked{
	if (_link != NULL &&  _link != nil) {
		if ([self.delegate respondsToSelector:@selector(handleImageClick:)]) {
			[self.delegate performSelector:@selector(handleImageClick:) withObject:_link];
		}
	}
}

#pragma mark -

- (void)dealloc {
  [self cancelImageLoad];
  [_request clearDelegatesAndCancel];
  [_request release], _request = nil;  
	[imageURL release], imageURL = nil;
	[placeholderImage release], placeholderImage = nil;
  [_borderColor release], _borderColor = nil;
  [_link release], _link = nil;
	[super dealloc];
}

@end
