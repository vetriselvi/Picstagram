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

    [[DataSource sharedInstance] addObserver:self forKeyPath:@"mediaItems" options:0 context:nil];

    [self.tableView registerClass:[MediaTableViewCell class] forCellReuseIdentifier:@"mediaCell"];
    
  //  [self.tableView reloadData];

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Media *mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row]; //find and replace instead of refactoring
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
    NSLog(@"number of tasks when tableview:%d", self.mediaItems.count);

    return[DataSource sharedInstance].mediaItems.count;
    //return self.mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    MediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mediaCell" forIndexPath:indexPath];
    cell.mediaItem = self.mediaItems[indexPath.row];
//    cell.mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];

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
    }
}
//- (NSArray *)mediaItems
//{
//    return [DataSource sharedInstance].mediaItems;
//}

#pragma mark - Handler for Key-Value Notification

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == [DataSource sharedInstance] && [keyPath isEqualToString:@"mediaItems"]) {
        // determine what kind of change it is
        int kindOfChange = [change[NSKeyValueChangeKindKey] intValue];
        
        if (kindOfChange == NSKeyValueChangeSetting) {
            // Someone set a brand new immage array
            [self.tableView reloadData];
        } else if ((kindOfChange == NSKeyValueChangeInsertion) ||
                   (kindOfChange == NSKeyValueChangeRemoval) ||
                   (kindOfChange == NSKeyValueChangeReplacement)) {
            // if its an insertion, removal, or replacement get a list of the index/indices
            NSIndexSet *indexSetOfChanges = change[NSKeyValueChangeIndexesKey];
            
            // Convert the NSIndexSet to an NSArray of NSIndexedPaths
            NSMutableArray *indexPathsThatChanged = [NSMutableArray array];
            [indexSetOfChanges enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
                NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
                [indexPathsThatChanged addObject:newIndexPath];
            }];
            
            // Call BeginUpdate to tell the tableView we're about to make changes
            [self.tableView beginUpdates];
            
            // then tell the tableView what the specific changes are
            if (kindOfChange == NSKeyValueChangeInsertion) {
                [self.tableView insertRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeRemoval) {
                [self.tableView deleteRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            } else if (kindOfChange == NSKeyValueChangeReplacement) {
                [self.tableView reloadRowsAtIndexPaths:indexPathsThatChanged withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            
            // Tell the tableView that we have completed telling about changes - completes the animation
            [self.tableView endUpdates];
        }
    }
}

#pragma mark - dealloc
- (void) dealloc
{
    [[DataSource sharedInstance] removeObserver:self forKeyPath:@"mediaItems"];
}

- (NSArray *)mediaItems {
    return [DataSource sharedInstance].mediaItems;
}
@end
