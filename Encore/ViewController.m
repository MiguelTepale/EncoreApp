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

-(void)artistEntryNotValidAlert {
    UIAlertController * alert = [UIAlertController
                                                                       alertControllerWithTitle:@"Alert!"
                                                                       message:@"Artist is not valid. Please check spelling or try another artist"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction *okAction = [UIAlertAction
                                                                   actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action)
                                                                   {
                                                                           NSLog(@"OK action");
                                                                       }];
    
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    
    }

@end
