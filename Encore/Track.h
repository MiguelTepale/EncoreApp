//
//  Track.h
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Track : NSObject

@property (nonatomic) int discNumber;
@property (nonatomic) int trackNumber;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) long time;

@end
