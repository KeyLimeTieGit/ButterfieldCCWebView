//
//  ViewController.m
//  CentauriWebView
//
//  Created by Sameer Siddiqui on 10/19/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Navigation.h"
#import "UIViewController+activity.h"
#import "AppDelegate.h"



@interface ViewController () <SWRevealViewControllerDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@end

@implementation ViewController

+ (ViewController *)create {
    ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _webView.scrollView.bounces = NO;
    _webView.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:219.0/255.0 blue:223.0/255.0 alpha:1.00];
    self.webView.opaque=NO;

    [self setNeedsStatusBarAppearanceUpdate];
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    self.revealViewController.delegate = self;
    self.revealViewController.rearViewRevealDisplacement = 0;

    [_menuButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];

     [self navBarWithTitle:@"Centauri" andLeftButtonImage:[UIImage imageNamed:@"icon_sideMenu"]  leftButtonSelector:@selector(revealToggle:) leftTarget:revealController andRightButtonImage:nil rightButtonSelector:nil];
    
    UIView *addStatusBar = [[UIView alloc] init];
    addStatusBar.frame = CGRectMake(0, -20, self.view.bounds.size.width, 20);
    addStatusBar.backgroundColor =  [UIColor colorWithRed:0.827 green:0.859 blue:0.875 alpha:1.00];
    [self.view addSubview:addStatusBar];
    [self.navigationController.navigationBar addSubview:addStatusBar];
    
    NSString *urlAddress = @"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
    _webView.delegate=self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *urlAddress = @"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)loadWebWithURL:(NSString *)urlString {
    NSString *urlAddress = urlString;
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showIndicator];
    });

    NSLog(@"started");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self hideIndicator];

    if ([webView.request.URL.absoluteString containsString:@"login"] || [webView.request.URL.absoluteString isEqualToString:@"https://butterfieldcc.org/"]) {
        [[AppDelegate appDelegate] flipToLogin];
    }
    
    NSLog(@"finished");
}

//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    [self hideIndicator];
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry"
//                                                                   message:@"The page could not load\nPlease try again"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    
//  
//    UIAlertAction* user3 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
//                                                  handler:^(UIAlertAction * action) {
//                                                     
//                                                  }];
//       [alert addAction:user3];
//    
//    [self presentViewController:alert animated:YES completion:nil];
//    NSLog(@"%@",error.localizedDescription);
//}

#pragma mark - SWRevealViewControllerDelegate

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position {
    if (FrontViewPositionRight == position) {
        self.view.userInteractionEnabled = NO;
    }
    else if (FrontViewPositionLeft == position) {
        self.view.userInteractionEnabled = YES;
    }
}

- (IBAction)phoneButtonPressed:(id)sender {
    NSURL *phoneNumber = [NSURL URLWithString:@"telprompt://+1(630)323-1000"];
    [[UIApplication sharedApplication] openURL:phoneNumber options:@{} completionHandler:nil];
}

@end
