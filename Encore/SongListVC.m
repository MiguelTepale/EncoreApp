//
//  SongListVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "SongListVC.h"
#import "Track.h"


@implementation SongListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    // Add a back button on the left side of the navigation bar
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(performBackNavigation:)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.albumArtImageView.image = [[UIImage alloc]initWithData:self.album.imageData];

    self.songTableView.delegate = self;
    self.songTableView.dataSource = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method is called when the user hit the back button.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) performBackNavigation:(id)sender
{
    // Exit current screen
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.trackList.count;
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
    
    // Get the corresponding track for the row
    Track *track = self.trackList[indexPath.row];
    
    // Get the first and last track
    Track *firstTrack = self.trackList[0];
    Track *lastTrack = self.trackList[self.trackList.count - 1];
    
    // if the first and last track are on the same disc then ...
    if (firstTrack.discNumber == lastTrack.discNumber)
        // display the current track without the disc number
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d   %@", track.trackNumber, track.name];
    // Otherwise, ...
    else
        // This is a mult-disc album, display the disc number along with track info
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%d - %d   %@", track.discNumber, track.trackNumber, track.name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//Cell will not highlight. If you want to enable selecting a cell, go to songlistVC.xibxr and select "selection" and change it from "no selection" to "single selection"
}

@end
