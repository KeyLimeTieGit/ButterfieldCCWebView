//
//  UIViewController+Navigation.h
//  Dua
//
//  Created by Sameer Siddiqui on 11/18/15.
//  Copyright © 2015 Sameer Siddiqui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)
- (void)navBarWithTitle:(NSString *)title
     andLeftButtonImage:(UIImage *)leftButtonImage
     leftButtonSelector:(SEL)leftButtonSelector
             leftTarget:(id)target
    andRightButtonImage:(UIImage *)rightButtonImage
    rightButtonSelector:(SEL)rightButtonSelector;
- (void)setNavBarTitle:(NSString *)title;
@end
