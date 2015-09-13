//
//  MediaTableViewCell.h
//  Picstagram
//
//  Created by Vetri Selvi Vairamuthu on 9/13/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
#import "User.h"
#import "Comment.h"
@class Media;

@interface MediaTableViewCell : UITableViewCell
+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;
@property(nonatomic,strong)Media *mediaItem;

@end
