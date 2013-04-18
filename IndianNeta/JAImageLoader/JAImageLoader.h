//
//  JAImageLoader.h
//  JustAsk
//
//  Created by askdev on 28/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JAImageLoaderObserver;
@interface JAImageLoader : NSObject/*<NSURLConnectionDelegate>*/ {
@private
	NSDictionary* _currentConnections;
	NSMutableDictionary* currentConnections;
	
	NSLock* connectionsLock;
}

+ (JAImageLoader*)sharedImageLoader;

- (BOOL)isLoadingImageURL:(NSURL*)aURL;
- (void)loadImageForURL:(NSURL*)aURL observer:(id<JAImageLoaderObserver>)observer;
- (UIImage*)imageForURL:(NSURL*)aURL shouldLoadWithObserver:(id<JAImageLoaderObserver>)observer;
- (BOOL)hasLoadedImageURL:(NSURL*)aURL;

- (void)cancelLoadForURL:(NSURL*)aURL;

- (void)removeObserver:(id<JAImageLoaderObserver>)observer;
- (void)removeObserver:(id<JAImageLoaderObserver>)observer forURL:(NSURL*)aURL;

@property(nonatomic,retain) NSDictionary* currentConnections;
@end

@protocol JAImageLoaderObserver<NSObject>
@optional
- (void)imageLoaderDidLoad:(NSNotification*)notification;
- (void)imageLoaderDidFailToLoad:(NSNotification*)notification;
@end