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


@interface ImageTableViewController ()
//@property(nonatomic,strong) NSMutableArray *imageArray;

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    

}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   // UIImage *image = self.imageArray[indexPath.row];
    Media *mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];
    UIImage *image = mediaItem.image;
    
    
    return (CGRectGetWidth(self.view.frame)/image.size.width) * image.size.height;
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
    return [DataSource sharedInstance].mediaItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    // Cell configuration
    
    static NSInteger imageViewTag = 1234;
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:imageViewTag];
    
    if(!imageView){
        
        imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.frame = cell.contentView.bounds;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        imageView.tag = imageViewTag;
        
        [cell.contentView addSubview:imageView];
    }
    
   // UIImage *image = self.imageArray[indexPath.row];
    //imageView.image = image;

    Media *mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];
    imageView.image=mediaItem.image;
    
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    
    return YES;
}

/* doubt - error while deleting

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Media *mediaItem = [DataSource sharedInstance].mediaItems[indexPath.row];
       //[self.imageArray removeObjectAtIndex:indexPath.row];
        //[[DataSource sharedInstance].mediaItems removeObjectAtIndex:mediaItem];
       //  [DataSource sharedInstance].mediaItems delete
//         [[self tableView] reloadData];
       
       
        if (mediaItem) {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        

        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        
    }   
}

*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
