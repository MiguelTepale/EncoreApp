//
//  ResultsVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Artist.h"


@interface ResultsVC : UIViewController<UITableViewDelegate, UITableViewDataSource,UITabBarControllerDelegate,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UITabBar *resultsTabBar;
@property (weak, nonatomic) IBOutlet UITableView *eventsTableView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *albumsTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *eventsTab;
@property (strong, nonatomic) Artist *artist;

@end
