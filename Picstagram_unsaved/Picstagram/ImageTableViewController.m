//
//  ImageTableViewController.m
//  Picstagram
//
//  Created by Vetri Selvi Vairamuthu on 9/8/15.
//  Copyright (c) 2015 Vetri Selvi Vairamuthu. All rights reserved.
//

#import "ImageTableViewController.h"
#import "DataSource.h"
#import "Media.h"
#import "User.h"
#import "Comment.h"
#import "MediaTableViewCell.h"

@interface ImageTableViewController ()
@property(nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic, readonly)  NSArray *mediaItems; // NSMutableArray *mediaItems;
@end

@implementation ImageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *mediaItem = self.mediaItems[indexPath.row]; //find and replace instead of refactoring

    return [MediaTableViewCell heightForMediaItem:mediaItem width:CGRectGetWidth(self.view.frame)];

}


-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
       // self.imageArray = [NSMutableArray array];
    }
    
    return self;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//  return self.imageArray.count;
    
    return self.mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = self.mediaItems[indexPath.row];

    return cell;
}

// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
        [[DataSource sharedInstance] deleteMediaItem:item];
    }
}


- (NSArray *)mediaItems
{
    return [DataSource sharedInstance].mediaItems;
}

#pragma mark - Handler for Key-Value Notification

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        // Nothing… YET
    }
}

#pragma mark - dealloc
- (void) dealloc
{
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

@end
