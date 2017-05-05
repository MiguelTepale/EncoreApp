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
#import "ResultsVC.h"


@implementation Artist
{
    Model *_model;
    Album *currentAlbum;
    UINavigationController *_navigationController;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that execute the search for an artist events.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findEvents:(NSString *)artistName displayUnder:(UINavigationController *) controller
{
    _navigationController = controller;
    
    // Pass the request to the backend
    [_model findEvents:artistName];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that execute the search for an album's track.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findTracks:(long) albumIndex displayUnder:(UINavigationController *) controller
{
    currentAlbum = self.albumList[albumIndex];
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
        _model.eventsDelegate = self;
    }
    
    return self;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that is called by the Model to return the result of an artist's event search.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didFindEvents:(NSArray *)events
{
    ResultsVC *resultsVC = (ResultsVC *) _navigationController.topViewController;
    [resultsVC loadEvents:events];
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
    controller.album = currentAlbum;
    controller.trackList = tracks;
    
    
    // Display the track list.
    [_navigationController pushViewController:controller animated:YES];
}

- (void) didNotFindEvents:(NSString *)errorMsg
{
    
}

- (void) didNotFindTracks:(NSString *)errorMsg
{

}

@end
