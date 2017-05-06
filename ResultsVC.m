//
//  ResultsVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "ResultsVC.h"
#import "SongListVC.h"
#import "WebVC.h"


@implementation ResultsVC
{
    int _requestCount;
    NSArray *_eventList;
}

- (void) loadEvents:(NSArray *)events
{
    self.eventsTableView.hidden = false;
    self.resultsTableView.hidden = true;
    
    _eventList = events;
    
    [self.eventsTableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = self.artist.name;
    self.eventsTableView.contentInset = UIEdgeInsetsMake(65,0,0,0);
    
    // Add a back button on the left side of the navigation bar
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(performBackNavigation:)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;

    self.tabBar.delegate = self;
    
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self;
    
    self.eventsTableView.delegate = self;
    self.eventsTableView.dataSource = self;
    
    _requestCount = 0;
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
    if (tableView == self.resultsTableView)
        return self.artist.albumList.count;
    else
        return _eventList.count;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    
    if (tableView == self.resultsTableView)
    {
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
    }
    else
    {
        Event *event = _eventList[indexPath.row];
        
        NSString *dateString = [NSDateFormatter localizedStringFromDate:event.date
                                                              dateStyle:NSDateFormatterFullStyle
                                                              timeStyle:NSDateFormatterNoStyle];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ - %@", dateString, event.venueName];
        cell.detailTextLabel.text = event.venueLocation;
    }

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
    if (tableView == self.resultsTableView)
        [self.artist findTracks:indexPath.row displayUnder: self.navigationController];
    else
    {
        WebVC *webVC = [[WebVC alloc] init];
        Event *event = _eventList[indexPath.row];
        webVC.url = event.eventURL;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark - UITabBar Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method that is called when the user touches an item on the tab bar.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (item == self.albumsTab)
    {
        if (self.resultsTableView.hidden)
        {
            self.eventsTableView.hidden = true;
            self.resultsTableView.hidden = false;
        }
    }
    else if (self.eventsTableView.hidden)
    {
        if ([self.eventsTableView numberOfRowsInSection:0] > 0)
        {
            self.eventsTableView.hidden = false;
            self.resultsTableView.hidden = true;
        }
        else
        {
            [self.artist findEvents:self.artist.name displayUnder:self.navigationController];
        }
    }
}

@end
