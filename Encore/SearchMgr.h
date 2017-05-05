//
//  SearchMgr.h
//  Encore
//
//  Created by bl on 5/5/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Model.h"


@interface SearchMgr : NSObject<ModelArtistDelegate>

@property (strong, nonatomic) UINavigationController *navigationController;

- (instancetype) init;
- (void) findArtist:(NSString *) name;

@end
