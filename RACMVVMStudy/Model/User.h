//
//  User.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Services.h"
#import "UserModel.h"

@interface User : NSObject
@property (strong, nonatomic, readonly) Services *services;
@property (strong, nonatomic) UserModel *userModel;
@property (assign, nonatomic, readonly, getter=isValidOfUsername) BOOL validOfUsername;
@property (assign, nonatomic, readonly, getter=isValidOfPassword) BOOL validOfPassword;

+ (instancetype)userWithServices:(Services *)services userModel:(UserModel *)model;
- (instancetype)initWithServices:(Services *)services userModel:(UserModel *)model;

- (RACSignal *)loginSignal;
- (RACSignal *)logoutSignal;
@end
