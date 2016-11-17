//
//  UIManager.h
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIManager : NSObject

+ (void)showHUD;
+ (void)dismissHUD;

+ (UIAlertController *)showErrorWithMessage:(NSString *)message;
+ (UIAlertController *)createNativeAlertViewControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle;

@end
