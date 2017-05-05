//
//  Model.h
//  ArtistSearchApp
//
//  Created by bl on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Album.h"
#import "Event.h"


@protocol ModelArtistDelegate <NSObject>

- (void) didFindArtist:(NSArray *)albums;
- (void) didNotFindArtist:(NSString *)errorMsg;

@end


@protocol ModelEventsDelegate <NSObject>

- (void) didFindEvents:(NSArray *)events;
- (void) didNotFindEvents:(NSString *)errorMsg;

@end


@interface Model : NSObject

@property (strong, nonatomic) id<ModelArtistDelegate> artistDelegate;
@property (strong, nonatomic) id<ModelEventsDelegate> eventsDelegate;

- (void) findArtist:(NSString *)artistName;
- (void) findEvents:(NSString *)artistName;
+ (Model *) sharedInstance;

@end
