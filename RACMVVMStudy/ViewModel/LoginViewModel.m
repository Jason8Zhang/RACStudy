//
//  LoginViewModel.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD.h"
#import "SearchViewModel.h"
@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        _user = [[User alloc] init];
    }
    return self;
}
+ (instancetype)loginViewModelWithUser:(User *)user {
    return [[self alloc] initWithUser:user];
}
- (instancetype)initWithUser:(User *)user {
    if (self = [super init]) {
        self.user = user;
        
        //创建有效的用户名密码信号
        @weakify(self);
        RACSignal *validUS = [[RACObserve(self.user.userModel, username) map:^id _Nullable(id  _Nullable value) {
            @strongify(self);
            return @(self.user.isValidOfUsername);
        }] distinctUntilChanged];
        RACSignal *validPS = [[RACObserve(self.user.userModel, password) map:^id _Nullable(id  _Nullable value) {
            @strongify(self);
            return @(self.user.isValidOfPassword);
        }] distinctUntilChanged];
        
        //合并有效的用户名密码信号作为控制登录按钮可用的信号
        RACSignal *validLS = [RACSignal combineLatest:@[validUS, validPS] reduce:^id _Nonnull(id first, id second) {
            return @([first boolValue] && [second boolValue]);
        }];
        
        self.loginCommand = [[RACCommand alloc] initWithEnabled:validLS signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            return [[self.user loginSignal] logAll];
        }];
    }
    
    return self;
}
@end
