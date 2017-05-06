//
//  WebVC.m
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import "WebVC.h"

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
                                                                  action:@selector(segueToMapVc)];
    [backButton setTitleTextAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:30] }
                              forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = mapButton;
    
    self.navigationItem.title = @"Event";
    
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc]init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:screenBounds configuration:webConfiguration];
    webView.navigationDelegate = self;
    
    NSURL *website = [NSURL URLWithString: self.url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:website];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];
}

- (void)performBackNavigation {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
