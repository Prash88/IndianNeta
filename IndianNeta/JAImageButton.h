//
//  JAImageButton.h
//  JustAsk
//
//  Created by Vasanth on 01/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JAImageLoader.h"
#import "ASIHTTPRequest.h"

@protocol JAImageButtonDelegate;
@interface JAImageButton : UIButton <JAImageLoaderObserver>{
@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<JAImageButtonDelegate> delegate;
	ASIHTTPRequest *_request;
	NSString *_borderColor;
	NSString *_link;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage;
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<JAImageButtonDelegate>)aDelegate;
- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<JAImageButtonDelegate> delegate;
@property(nonatomic,retain) ASIHTTPRequest *request;
@property(nonatomic,retain) NSString *borderColor;
@property(nonatomic,retain) NSString *link;

@end

@protocol JAImageButtonDelegate<NSObject>
@optional
- (void)imageButtonLoadedImage:(JAImageButton*)imageButton;
- (void)imageButtonFailedToLoadImage:(JAImageButton*)imageButton error:(NSError*)error;
- (void)handleImageClick:(NSString *)hyperlink;
@end