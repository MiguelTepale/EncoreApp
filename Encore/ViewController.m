//
//  ViewController.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//


#import "ViewController.h"
#import "SearchMgr.h"


@interface ViewController ()

@end

@implementation ViewController
{
    SearchMgr *_searchMgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _searchMgr = [[SearchMgr alloc] init];
    _searchMgr.navigationController = self.navigationController;
}

- (void)viewDidAppear:(BOOL)animated
{
    [_searchMgr findArtist:@"Ozzy Osbourne"];
    // Display progress bar ???
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
