//
//  AppDelegate.h
//  CentauriWebView
//
//  Created by Sameer Siddiqui on 10/19/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@class SWRevealViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
+ (AppDelegate *)appDelegate;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *dashboardViewController;
@property (strong, nonatomic) SWRevealViewController *viewController;

@end

