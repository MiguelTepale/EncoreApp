//
//  Artist.h
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Album.h"
#import "Event.h"
#import "Track.h"


@interface Artist : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *albumList;
@property (strong, nonatomic) NSMutableArray *eventList;

@end
