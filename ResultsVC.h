//
//  ResultsVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *artistImageView;
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@property (weak, nonatomic) IBOutlet UITabBarItem *albumsTab;
@property (weak, nonatomic) IBOutlet UITabBarItem *eventsTab;

@end
