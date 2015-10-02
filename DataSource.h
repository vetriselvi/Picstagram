//
//  DataSource.h
//  Picstagram
//
//  Created by Vetri Selvi Vairamuthu on 9/9/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

@interface DataSource : NSObject
+(instancetype) sharedInstance;

@property(nonatomic,strong, readonly) NSArray *mediaItems;

- (void)removeMediaItem:(Media *)mediaItem; //add specific methods for adding/removing

- (void)addMediaItem:(Media *)mediaItem;
- (void) deleteMediaItem:(Media *)item;


@end
