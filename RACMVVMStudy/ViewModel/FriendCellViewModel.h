//
//  FriendCellViewModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendModel.h"
#import <ReactiveObjC.h>
@interface FriendCellViewModel : NSObject
@property (strong, nonatomic) FriendModel *friendModel;

+ (instancetype)friendCellViewModel:(FriendModel *)model;
- (instancetype)initWithFriendModel:(FriendModel *)model;
- (RACSignal*)selectedSignal;
@end
