//
//  JAImageLoadingConnection.h
//  JustAsk
//
//  Created by askdev on 28/06/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JAImageLoadConnectionDelegate;

@interface JAImageLoadConnection : NSObject {
@private
	NSURL* _imageURL;
	NSURLResponse* _response;
	NSMutableData* _responseData;
	NSURLConnection* _connection;
	NSTimeInterval _timeoutInterval;
	
	id<JAImageLoadConnectionDelegate> _delegate;
}

- (id)initWithImageURL:(NSURL*)aURL delegate:(id)delegate;

- (void)start;
- (void)cancel;

@property(nonatomic,readonly) NSData* responseData;
@property(nonatomic,readonly,getter=imageURL) NSURL* imageURL;

@property(nonatomic,retain) NSURLResponse* response;
@property(nonatomic,assign) id<JAImageLoadConnectionDelegate> delegate;

@property(nonatomic,assign) NSTimeInterval timeoutInterval; // Default is 30 seconds

@end

@protocol JAImageLoadConnectionDelegate<NSObject>
- (void)imageLoadConnectionDidFinishLoading:(JAImageLoadConnection *)connection;
- (void)imageLoadConnection:(JAImageLoadConnection *)connection didFailWithError:(NSError *)error;	
@end