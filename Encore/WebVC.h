//
//  WebVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"


@interface WebVC : UIViewController <UIWebViewDelegate>

@property(weak, nonatomic) NSString *url;
@property (strong, nonatomic) Event *event;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityInd;

@end
