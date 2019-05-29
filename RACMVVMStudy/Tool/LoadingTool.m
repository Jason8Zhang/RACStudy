//
//  LoadingTool.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "LoadingTool.h"
#import <MBProgressHUD.h>
@implementation LoadingTool
+ (void)showTo:(UIView *)view {
    [MBProgressHUD showHUDAddedTo:view animated:NO];
}
+ (void)showMessage:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.userInteractionEnabled = YES;
    [hud hideAnimated:YES afterDelay:3];
}
+ (void)hideFrom:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:NO];
}
@end
