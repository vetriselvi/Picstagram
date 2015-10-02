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

+ (instancetype) sharedInstance;

@property (nonatomic, strong, readonly) NSArray *mediaItems;  // _mediaItems


/*
 
 Properties do 3 things:
 
 1. They synthesize a backing variable with _nameOfVariable
 2. They make a getter   // self.mediaItems
 3. They make a setter  // self.mediaItems =
 
 
 */

//- (void)removeMediaItem:(Media *)mediaItem; //add specific methods for adding/removing
//
//- (void)addMediaItem:(Media *)mediaItem;

- (void) deleteMediaItem:(Media *)item;

@end
