//
//  SongListVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongListVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *albumArtImageView;
@property (weak, nonatomic) IBOutlet UITableView *songTableView;

@end
