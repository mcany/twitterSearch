//
//  UIManager.m
//  twitter-search
//
//  Created by mcan on 17/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "UIManager.h"

// library
#import "SVProgressHUD.h"

@implementation UIManager

+ (void)showHUD {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
}

+ (void)dismissHUD {
    [SVProgressHUD dismiss];
}

+ (UIAlertController *)showErrorWithMessage:(NSString *)message {
    UIAlertController *alert= [UIManager createNativeAlertViewControllerWithTitle:@"Hata"
                                                                          message:message
                                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Tamam"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action){
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [alert addAction:ok];
    return alert;
}

+ (UIAlertController *)createNativeAlertViewControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle{
    UIAlertController *alert=   [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:preferredStyle];
    
    return alert;
}

@end
