//
//  AppDelegate.m
//  CentauriWebView
//
//  Created by Sameer Siddiqui on 10/19/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "RearViewController.h"
#import "LoginViewController.h"
#import "DummyViewController.h"



@interface AppDelegate () <SWRevealViewControllerDelegate, LoginCheck>

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [NSThread sleepForTimeInterval:0.5];

    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    
    [UINavigationBar appearance].barTintColor =  [UIColor colorWithRed:0.827 green:0.859 blue:0.875 alpha:1.00];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].backgroundColor = [UIColor colorWithRed:0.827 green:0.859 blue:0.875 alpha:1.00];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    

    ViewController *frontViewController = [ViewController create];
    RearViewController *rearViewController = [RearViewController create];
    

    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontViewController];
    revealController.delegate = self;
    revealController.rearViewRevealWidth = 215;
    
    self.dashboardViewController = frontViewController;
    self.viewController = revealController;
    frontViewController.revealViewController = revealController;
        
    DummyViewController *dummy = [DummyViewController create];
    dummy.delegate = self;
    self.window.rootViewController = dummy;
    
    [self.window makeKeyAndVisible];


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - SWRevealViewDelegate

- (id <UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if ( operation != SWRevealControllerOperationReplaceRightController )
        return nil;
    
    return nil;
}


#pragma mark - Root View Controller

- (void)flipToDashboard {
    [self flipViewController:self.viewController withCompletionBlock:nil];
}
- (void)flipToLogin {
    LoginViewController *vc = [LoginViewController create];
    [self flipViewController:vc withCompletionBlock:nil];

}

- (void)flipViewController:(UIViewController *)viewController withCompletionBlock:(void (^)(id selectedValue))completionBlock {
    // Display the new view controller with a flip animation
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.window.rootViewController.view removeFromSuperview];
                        [self.window addSubview:viewController.view];
                        self.window.rootViewController = viewController;
                        
                        if (completionBlock) {
                            completionBlock(self.dashboardViewController);
                        }
                    }
                    completion:NULL];
}

- (void)userLoggedIn:(BOOL)loggedIN {
    if (loggedIN) {
        [self flipViewController:self.viewController withCompletionBlock:^(id selectedValue) {
            
        }];
    }
    else {
        
        LoginViewController *vc = [LoginViewController create];
        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];


    }
}


@end
