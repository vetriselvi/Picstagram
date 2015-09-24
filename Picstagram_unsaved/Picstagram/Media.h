//
//  Media.h
//  Picstagram
//
//  Created by Vetri Selvi Vairamuthu on 9/9/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class User;

@interface Media : NSObject
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;

@end
