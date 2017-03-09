//
//  DummyViewController.h
//  ButterfieldCCWebView
//
//  Created by Sameer Siddiqui on 3/9/17.
//  Copyright © 2017 KeyLimeTie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginCheck <NSObject>

- (void)userLoggedIn:(BOOL)loggedIN;

@end

@interface DummyViewController : UIViewController
+ (DummyViewController*)create;

@property (weak, nonatomic) id <LoginCheck> delegate;
@end
