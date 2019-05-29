//
//  FriendCellViewModel.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "FriendCellViewModel.h"

@implementation FriendCellViewModel
- (instancetype)initWithFriendModel:(FriendModel *)model {
    if (self = [super init]) {
        self.friendModel = model;
    }
    
    return self;
}
+ (instancetype)friendCellViewModel:(FriendModel *)model {
    return [[self alloc] initWithFriendModel:model];
}
@end
