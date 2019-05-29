//
//  LoadingTool.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingTool : NSObject
+ (void)showTo:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideFrom:(UIView *)view;
@end
