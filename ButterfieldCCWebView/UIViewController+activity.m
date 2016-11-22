//
//  UIViewController+activity.m
//  ACGDeals
//
//  Created by Sameer Siddiqui on 5/9/16.
//  Copyright © 2016 KeyLimeTie. All rights reserved.
//

#import "UIViewController+activity.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>


@implementation UIViewController (activity)
static char _aControllerLoadingIndicator;
MBProgressHUD *hud;
- (void)showIndicator {
    @synchronized (self) {
        if (hud){
            [hud hide:YES];
            hud = nil;
            [hud removeFromSuperview];
        }
        
        hud = [[(NSClassFromString(@"MBProgressHUD")) alloc]initWithView:self.view];
        hud.userInteractionEnabled = NO;
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.color = [UIColor lightGrayColor];
        [self.view addSubview:hud];
        [hud show:YES];
        objc_setAssociatedObject(self, &_aControllerLoadingIndicator, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
}

- (void)hideIndicator {
    @synchronized (self) {
        hud = objc_getAssociatedObject(self, &_aControllerLoadingIndicator);
        if (hud && [hud isKindOfClass:[(NSClassFromString(@"MBProgressHUD")) class]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:NO];
                objc_removeAssociatedObjects(hud);
                
            });
        }
    }
}

@end
