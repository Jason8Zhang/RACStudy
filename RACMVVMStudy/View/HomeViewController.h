//
//  HomeViewController.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewModel.h"

@interface HomeViewController : UIViewController

+ (instancetype)homeViewControllerWithViewModel:(HomeViewModel *)viewModel;
- (instancetype)initWithViewModel:(HomeViewModel *)viewModel;

@end
