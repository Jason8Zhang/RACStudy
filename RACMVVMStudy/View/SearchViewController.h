//
//  SearchViewController.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewModel.h"

@interface SearchViewController : UIViewController

+ (instancetype)searchViewControllerWithViewModel:(SearchViewModel *)viewModel;
- (instancetype)initWithViewModel:(SearchViewModel *)viewModel;

@end
