//
//  FriendTableViewCell.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCellViewModel.h"
@interface FriendTableViewCell : UITableViewCell
@property (strong, nonatomic) FriendCellViewModel *viewModel;

+ (instancetype)friendCell:(UITableView *)tableView viewModel:(FriendCellViewModel *)viewModel;
@end
