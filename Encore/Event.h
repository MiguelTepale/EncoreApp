//
//  Event.h
//  Encore
//
//  Created by bl on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Event : NSObject

@property (strong, nonatomic) NSString *eventURL;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *venueName;
@property (strong, nonatomic) NSString *venueLocation;
@property (nonatomic) Boolean soldOut;
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

@end
