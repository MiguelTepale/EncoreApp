//
//  WebVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import "WebVC.h"
#import "MapVC.h"


@interface WebVC ()

@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(performBackNavigation)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"MapIt"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(segueToMapVC)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = mapButton;
    
    self.navigationItem.title = @"Event";
    
    self.webView.delegate = self;
    NSURL *website = [NSURL URLWithString: self.url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:website];
    [self.webView loadRequest:urlRequest];
}

- (void)performBackNavigation {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) segueToMapVC {
    MapVC *mapVC = [[MapVC alloc] init];
    mapVC.event = self.event;
    mapVC.title = @"Event Location";
    [self.navigationController pushViewController:mapVC animated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityInd startAnimating];
    self.activityInd.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityInd stopAnimating];
    self.activityInd.hidden = YES;
}

@end
