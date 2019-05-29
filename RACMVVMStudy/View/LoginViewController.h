//
//  LoginViewController.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"

@interface LoginViewController : UIViewController

- (instancetype)initWithLoginViewModel:(LoginViewModel *)viewModel;

@end
