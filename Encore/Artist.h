//
//  Artist.h
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Album.h"
#import "Event.h"
#import "Track.h"


@protocol ModelTracksDelegate;


@interface Artist : NSObject <ModelTracksDelegate>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *albumList;
@property (strong, nonatomic) NSMutableArray *eventList;

- (void) findTracks:(long) albumIndex displayUnder:(UINavigationController *) controller;
- (instancetype) init;

@end
