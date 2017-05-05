//
//  SongListVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Album.h"


@interface SongListVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *albumArtImageView;
@property (weak, nonatomic) IBOutlet UITableView *songTableView;
@property (strong, nonatomic) NSArray *trackList;
@property (weak, nonatomic) Album *album;

@end
