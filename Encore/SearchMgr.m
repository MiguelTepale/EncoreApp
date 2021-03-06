//
//  SearchMgr.m
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SearchMgr.h"
#import "ResultsVC.h"
#import "ViewController.h"


@implementation SearchMgr
{
    Model *_model;
}

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that execute the artist search.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) findArtist:(NSString *)name
{
    // Pass the request to the backend
    [_model findArtist:name];
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
        _model.artistDelegate = self;
    }
    
    return self;
}

#pragma mark - ModelArtistDelegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that is called by the Model to return the result of an artist search.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didFindArtist:(Artist *)artist
{
    
    ResultsVC *resultVC = [[ResultsVC alloc] init];
    resultVC.artist = artist;
    
    // Display the search results
    [self.activityInd stopAnimating];
    ViewController *vc = self.navigationController.viewControllers[0];
    vc.artistTextField.text = @"";
    [self.navigationController pushViewController:resultVC animated:YES];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method that implements the basic initializer.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didNotFindArtist:(NSString *)errorMsg
{
    [self.activityInd stopAnimating];
    ViewController *vc = self.navigationController.viewControllers[0];
    [vc displayError:errorMsg];
}


@end
