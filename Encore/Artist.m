//
//  Artist.m
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "Artist.h"
#import "Track.h"
#import "Model.h"
#import "SongListVC.h"


@implementation Artist
{
    Model *_model;
    Album *currentAlbum;
    UINavigationController *_navigationController;
    NSData *testData;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that execute the search for an album's track.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findTracks:(long) albumIndex displayUnder:(UINavigationController *) controller
{
    currentAlbum = self.albumList[albumIndex];
    testData = [currentAlbum.imageData copy];
    _navigationController = controller;
    
    // Pass the request to the backend
    [_model findTracks:currentAlbum.id];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that implements the basic initializer.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (instancetype) init
{
    if (self = [super init])
    {
        _model = [Model sharedInstance];
        _model.tracksDelegate = self;
    }
    
    return self;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that is called by the Model to return the result of an album's track search.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didFindTracks:(NSArray *)tracks
{
    // Initialize the track list view controller
    SongListVC *controller = [[SongListVC alloc] init];
    controller.title = currentAlbum.name;
//    controller.albumArtImageView.image = [UIImage imageWithData:currentAlbum.imageData];
    controller.albumArtImageView.image = [UIImage imageWithData:testData];
    controller.trackList = tracks;
    
    
    // Display the track list.
    [_navigationController pushViewController:controller animated:YES];
}

- (void) didNotFindTracks:(NSString *)errorMsg
{

}

@end
