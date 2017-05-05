//
//  Model.h
//  ArtistSearchApp
//
//  Created by bl on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Artist.h"


@protocol ModelArtistDelegate <NSObject>

- (void) didFindArtist:(Artist *)artist;
- (void) didNotFindArtist:(NSString *)errorMsg;

@end


@protocol ModelEventsDelegate <NSObject>

- (void) didFindEvents:(NSArray *)events;
- (void) didNotFindEvents:(NSString *)errorMsg;

@end


@protocol ModelTracksDelegate <NSObject>

- (void) didFindTracks:(NSArray *)tracks;
- (void) didNotFindTracks:(NSString *)errorMsg;

@end


@interface Model : NSObject

@property (strong, nonatomic) id<ModelArtistDelegate> artistDelegate;
@property (strong, nonatomic) id<ModelEventsDelegate> eventsDelegate;
@property (strong, nonatomic) id<ModelTracksDelegate> tracksDelegate;

- (void) findArtist:(NSString *)artistName;
- (void) findEvents:(NSString *)artistName;
- (void) findTracks:(long)albumId;
+ (Model *) sharedInstance;

@end
