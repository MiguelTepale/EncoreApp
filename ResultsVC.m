//
//  ResultsVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "ResultsVC.h"
#import "SongListVC.h"


@implementation ResultsVC
{
    int _requestCount;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.artist.name;
    
    // Add a back button on the left side of the navigation bar
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(performBackNavigation:)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;

    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
    self.resultsTabBar.delegate = self;
    
    _requestCount = 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"I have been pressed at index %@", self.resultsTabBar.selectedItem);
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method is called when the user hit the back button.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) performBackNavigation:(id)sender
{
    // Exit current screen
    [self.navigationController popViewControllerAnimated:NO];
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
                           
                           ++_requestCount;
                           
                           dispatch_sync(dispatch_get_main_queue(),
                                         ^{
                                             // display the image and ...
                                             cell.imageView.image = [[UIImage alloc] initWithData:imageData];
                                             // "cache" it
                                             album.imageData = imageData;
                                             
                                             // If all image request have been completed then ...
                                             if (0 == --_requestCount)
                                                 // refresh the table to see the image
                                                 [tableView reloadData];
                                         });
                       });
    }
    // Otherwise, ...
    else
        // display the "cached" image
        cell.imageView.image = [UIImage imageWithData:album.imageData];

    return cell;
}

#pragma mark - UITableView Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method that is called when the user select a row on the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.artist findTracks:indexPath.row displayUnder: self.navigationController];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
