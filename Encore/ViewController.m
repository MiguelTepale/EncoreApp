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
    self.backgroundImageView.image = [UIImage imageNamed:@"splash"];
    
    _searchMgr = [[SearchMgr alloc] init];
    _searchMgr.navigationController = self.navigationController;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    // Display progress bar ???
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to display an error message.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) displayError:(NSString *)errorMsg
{
    // Initialize the controller for displaying the message
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
                                                                   message:errorMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // Create an OK button
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    // Add the button to the controller
    [alert addAction:okButton];
    
    // Display the alert controller on the topmost viewController
    UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [navigationController.topViewController presentViewController:alert animated:YES completion:nil];
}


- (IBAction)searchArtist:(UIButton *)sender {
    NSString *validateText = [[NSString alloc] initWithString:self.artistTextField.text];
    validateText = [validateText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([validateText isEqualToString:@""]) {
        [self displayError:@"Artist is not valid. Please check spelling or try another artist"];
//        [self artistEntryNotValidAlert];
    }
    else {
        [self.activityInd startAnimating];
        _searchMgr.activityInd = self.activityInd;
        [_searchMgr findArtist:validateText];
    }
}

@end
