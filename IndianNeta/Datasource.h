//
//  Datasource.h
//  IndianNeta
//
//  Created by Prashanth on 1/14/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@protocol DataSourceDelegate;

@interface DataSource : NSOperation {
	id<DataSourceDelegate> _delegate;
}

@property(nonatomic, assign) id<DataSourceDelegate> delegate;

-(id) initWithDelegate:(id)delegate;
-(id) initWithDataSource:(DataSource *)datasource;
-(BOOL)shouldValidateErrorForResponse;

@end

