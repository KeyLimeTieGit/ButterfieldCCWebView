//
//  DummyViewController.m
//  ButterfieldCCWebView
//
//  Created by Sameer Siddiqui on 3/9/17.
//  Copyright © 2017 KeyLimeTie. All rights reserved.
//

#import "DummyViewController.h"
#import "AppDelegate.h"
#import "UIViewController+activity.h"


@interface DummyViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webview;
@property (nonatomic) int count;

@end

@implementation DummyViewController

+ (DummyViewController*)create {
    DummyViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DummyViewController class])];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webview = [[UIWebView alloc]init];
    self.count = 0;
//    NSString *urlAddress = @"https://www.butterfieldcc.org/login-939.html";
    NSString *urlAddress = @"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html";
    
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    if (password != nil && ![password isEqualToString:@""]) {

    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:requestObj];
    self.webview.delegate=self;
    }
    else {
        [self.delegate userLoggedIn:NO];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadWebWithURL:(NSString *)urlString {
    NSString *urlAddress = urlString;
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:requestObj];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showIndicator];
    });
    
//    NSLog(@"started");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self hideIndicator];
//
//    NSLog(@"finished");
    if ([webView.request.URL.absoluteString isEqualToString:@"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html"]) {
        NSLog(@"Matched website");
        [self.delegate userLoggedIn:YES];
        
    }
    else {
        [self executeJSClick];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
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
//    [alert addAction:user3];
//    
//    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"%@",error.localizedDescription);
}


- (void)executeJSClick {
    self.count++;
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    if (self.count <2 && password != nil && ![password isEqualToString:@""]) {
        
    
    NSString *fillDataJsCall = [NSString stringWithFormat:@"document.getElementById('lgUserName').value = '%@';document.getElementById('lgPassword').value = '%@';", username, password];
    [self.webview stringByEvaluatingJavaScriptFromString:fillDataJsCall];
    
    NSString *submit = @"document.getElementById('lgLoginButton').click()";
    [self.webview stringByEvaluatingJavaScriptFromString:submit];
    }
    else {
        [self.delegate userLoggedIn:NO];
    }

}

@end
