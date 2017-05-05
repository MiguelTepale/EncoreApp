//
//  ResultsVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "ResultsVC.h"


@implementation ResultsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.artist.name;
    
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
}

#pragma mark - UITableView Data Source Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of section in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of rows in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return self.artist.albumList.count;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method for loading data into current row of the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    // Get a recycled table row
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // If none are available then ...
    if (nil == cell)
        // Create a new row
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    
    Album *album = self.artist.albumList[indexPath.row];
    cell.textLabel.text = album.name;

    // If we haven't loaded the image yet then ...
    if (nil == album.imageData)
    {
        // load the image in the background.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:album.imageURL];
                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                           
                           dispatch_sync(dispatch_get_main_queue(),
                                         ^{
                                             // display the image and ...
                                             cell.imageView.image = [[UIImage alloc] initWithData:imageData];
                                             // "cache" it
                                             album.imageData = imageData;
                                         });
                       });
    }
    // Otherwise, ...
    else
        // display the "cached" image
        cell.imageView.image = [UIImage imageWithData:album.imageData];

    return cell;
}

#if 0
#pragma mark - UITableView Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method that is called when the user select a row on the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = [_articles objectAtIndex:indexPath.row];
    
    // Initialize the DetailViewController
    DetailViewController *controller = [[DetailViewController alloc] init];
    controller.url = [NSURL URLWithString:article.articleURL];
    controller.title = self.newsSourceTitle;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    // Display the DetailViewController.
    [self.navigationController pushViewController:controller animated:YES];
}
#endif

@end
