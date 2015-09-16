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
//@property(nonatomic,strong) NSMutableArray *imageArray;
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
#ifdef DEBUG
    NSLog(@"Cell recursive description:\n\n%@\n\n", [cell performSelector:@selector(recursiveDescription)]);
#endif
    return cell;
}

// Override to support conditional editing of the table view.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// Override to support editing the table view.

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Media *mediaItem = self.mediaItems[indexPath.row];
        
        if (mediaItem) {
            
           [[DataSource sharedInstance] removeMediaItem:mediaItem];
            //[self.mediaItems removeObjectAtIndex:indexPath.row];

            //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
        }
#ifdef DEBUG
        NSLog(@"Cell recursive description:\n\n%@\n\n", [[tableView cellForRowAtIndexPath:indexPath] performSelector:@selector(recursiveDescription)]);
#endif
        
    }
    else {
        NSLog(@"Unhandled editing style! %ld", (long)editingStyle);
    }

    
    
}

#pragma mark - refracted methods

- (NSArray *)mediaItems
{
    return [DataSource sharedInstance].mediaItems;
}



@end
