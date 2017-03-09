//
//  LoginViewController.h
//  ButterfieldCCWebView
//
//  Created by Sameer Siddiqui on 3/9/17.
//  Copyright © 2017 KeyLimeTie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Login <NSObject>

- (void)userLoggedInWithusername:(NSString *)username andPassword:(NSString *)password;

@end

@interface LoginViewController : UIViewController
+ (LoginViewController*)create;
@end
