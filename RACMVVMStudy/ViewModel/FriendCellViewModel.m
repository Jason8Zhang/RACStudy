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
- (RACSignal*)selectedSignal {
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        [subscriber sendNext:self->_friendModel];
        [subscriber sendCompleted];
        return nil;
    }];
}
@end
