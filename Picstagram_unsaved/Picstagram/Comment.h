//
//  Comment.h
//  Picstagram
//
//  Created by Vetri Selvi Vairamuthu on 9/9/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@class User;

@interface Comment : NSObject
@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;

@end
