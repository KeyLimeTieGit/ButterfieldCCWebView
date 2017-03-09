//
//  LoginViewController.m
//  ButterfieldCCWebView
//
//  Created by Sameer Siddiqui on 3/9/17.
//  Copyright © 2017 KeyLimeTie. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+activity.h"

#import "AppDelegate.h"

@interface LoginViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoToTopConstraint;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) UIWebView *webview;

@end

@implementation LoginViewController {
    BOOL tryedLogin;
}

+ (LoginViewController*)create {
    LoginViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([LoginViewController class])];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.username.alpha = 0;
    self.password.alpha = 0;
    self.loginButton.alpha = 0;
    
    self.loginButton.layer.cornerRadius = 4;
    
    self.username.delegate = self;
    self.password.delegate = self;
    
    
    self.webview = [[UIWebView alloc]init];

    self.webview.delegate=self;
    tryedLogin = NO;
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.backgroundImage addSubview:blurEffectView];
    blurEffectView.alpha = 0;
    
    NSString *urlAddress = @"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:requestObj];
    
    
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveEaseIn  animations:^{
        
        self.username.alpha = 1;
        self.password.alpha = 1;
        self.loginButton.alpha = 1;
        blurEffectView.alpha = 1;

        
    } completion:^(BOOL finished) {
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
   

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {

    
    NSString *fillDataJsCall = [NSString stringWithFormat:@"document.getElementById('lgUserName').value = '%@';document.getElementById('lgPassword').value = '%@';", self.username.text, self.password.text];
    [self.webview stringByEvaluatingJavaScriptFromString:fillDataJsCall];
    
    NSString *submit = @"document.getElementById('lgLoginButton').click()";
    [self.webview stringByEvaluatingJavaScriptFromString:submit];
    tryedLogin = YES;
}



- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (tryedLogin) {
        
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showIndicator];
        });
    
        NSLog(@"started");
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //    NSString *fillDataJsCall = [NSString stringWithFormat:@"document.getElementById('lgUserName').value = '%@';document.getElementById('lgPassword').value = '%@';", @"pautsch", @"Soda7632"];
    //    [webView stringByEvaluatingJavaScriptFromString:fillDataJsCall];
    //
    //    NSString *submit = @"document.getElementById('lgLoginButton').click()";
    //    [webView stringByEvaluatingJavaScriptFromString:submit];
    //
        [self hideIndicator];
    //
    //    NSLog(@"finished");
    if ([webView.request.URL.absoluteString isEqualToString:@"https://butterfieldcc.org/left/club-central/current-newsletter-1135.html"]) {
        NSLog(@"Matched website");
//        [self.delegate userLoggedIn:YES];
        [[NSUserDefaults standardUserDefaults]setObject:self.username.text forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"password"];
//        [[AppDelegate appDelegate].keyChain writeToKeychain];
        [[AppDelegate appDelegate] flipToDashboard];
        
    }
    else {
        if (tryedLogin) {
            
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry, Could not login"
                                                                           message:@"Please check your username and password"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction* user3 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                          }];
            [alert addAction:user3];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
        [self hideIndicator];
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry, Could not login"
                                                                       message:@"Please check your username and password"
                                                                preferredStyle:UIAlertControllerStyleAlert];
    
    
        UIAlertAction* user3 = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
    
                                                      }];
        [alert addAction:user3];
    
        [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"%@",error.localizedDescription);
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

@end
