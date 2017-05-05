//
//  WebVC.h
//  Encore
//
//  Created by Miguel Tepale on 5/4/17.
//  Copyright © 2017 Miguel Tepale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebVC : UIViewController <WKNavigationDelegate>

@property(weak, nonatomic) NSString *url;
@end
