//
//  ViewController.h
//  CentauriWebView
//
//  Created by Sameer Siddiqui on 10/19/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface ViewController : UIViewController
+ (ViewController *)create;
- (void)loadWebWithURL:(NSString *)urlString;
@property (nonatomic, weak) SWRevealViewController *revealViewController;


@end

