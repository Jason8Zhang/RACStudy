//
//  ResultsViewController.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsViewModel.h"

@interface ResultsViewController : UIViewController <UISearchBarDelegate>

+ (instancetype)resultsViewControllerWithViewModel:(ResultsViewModel *)viewModel;
- (instancetype)initWithViewModel:(ResultsViewModel *)viewModel;

@end
