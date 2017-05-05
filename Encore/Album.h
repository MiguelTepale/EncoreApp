//
//  Album.h
//  Encore
//
//  Created by bl on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>


@interface Album : NSObject

@property (nonatomic) long id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSData *imageData;

@end

