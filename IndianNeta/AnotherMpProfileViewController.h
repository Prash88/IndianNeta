//
//  AnotherMpProfileViewController.h
//  IndianNeta
//
//  Created by Prashanth on 4/17/13.
//  Copyright (c) 2013 StringConnect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MpProfile.h"
#import "JAImageButton.h"

@interface AnotherMpProfileViewController : UIViewController{
    
    MpProfile *_mpProfile;
    
}

@property (nonatomic,retain) MpProfile *mpProfile;
@property (nonatomic,assign) IBOutlet UILabel *name;
@property (nonatomic,assign) IBOutlet UILabel *constituency;
@property (nonatomic,assign) IBOutlet UILabel *party;
@property (nonatomic,assign) IBOutlet UILabel *email;

@property (nonatomic,assign) IBOutlet JAImageButton *image;


@end
