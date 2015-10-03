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
//    for(int i = 1 ; i <=10 ; i++){
//        NSString *imageName  = [NSString stringWithFormat:@"%d.jpg",i];
//        UIImage *image = [UIImage imageNamed:imageName];
//        if (image) {
//          //  [self.imageArray  addObject:image];
//        }

    
    //}
    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];

    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UIImage *image = self.imageArray[indexPath.row];
    Media *mediaItem = self.mediaItems[indexPath.row]; //find and replace instead of refactoring
//    UIImage *image = mediaItem.image;
//    return 300 + (CGRectGetWidth(self.view.frame)/image.size.width) * image.size.height;
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
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Cell configuration
//    
//    static NSInteger imageViewTag = 1234;
//    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
//    
//    if(!imageView){
//        
//        imageView = [[UIImageView alloc]init];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        imageView.frame = cell.contentView.bounds;
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        
//        imageView.tag = imageViewTag;
//        
//        [cell.contentView addSubview:imageView];
//    }
//    
//   // UIImage *image = self.imageArray[indexPath.row];
//    //imageView.image = image;
//
//    Media *mediaItem = self.mediaItems[indexPath.row];
//    imageView.image=mediaItem.image;
//    
    
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = self.mediaItems[indexPath.row];
    return cell;
}

// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Media *item = [DataSource sharedInstance].mediaItems[indexPath.row];
        
        [[DataSource sharedInstance] deleteMediaItem:item];
         //[self.imageArray removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
    }
}


- (NSArray *)mediaItems
{
    return [DataSource sharedInstance].mediaItems;
}

#pragma mark - Handler for Key-Value Notification

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        // We know mediaItems changed.  Let's see what kind of change it is.
        int kindOfChange = [change[NSKeyValueChangeKindKey] intValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new images array
            [self.tableView reloadData];
        
    } else if (kindOfChange == NSKeyValueChangeInsertion ||
               kindOfChange == NSKeyValueChangeRemoval ||
               kindOfChange == NSKeyValueChangeReplacement) {
        // We have an incremental change: inserted, deleted, or replaced images
        
        // Get a list of the index (or indices) that changed
        NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
        
        // #1 - Convert this NSIndexSet to an NSArray of NSIndexPaths (which is what the table view animation methods require)
        NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
        [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPathsThatChanged addObject:newIndexPath];
        }];
        
        // #2 - Call `beginUpdates` to tell the table view we're about to make changes
        [self.tableView beginUpdates];
        
        // Tell the table view what the changes are
        if (kindOfChange == NSKeyValueChangeInsertion) {
            [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (kindOfChange == NSKeyValueChangeRemoval) {
            [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (kindOfChange == NSKeyValueChangeReplacement) {
            [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Tell the table view that we're done telling it about changes, and to complete the animation
        self.tableView.translatesAutoresizingMaskIntoConstraints=NO;

        [self.tableView endUpdates];
            }
}
}


#pragma mark - dealloc
- (void) dealloc
{
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}
@end
