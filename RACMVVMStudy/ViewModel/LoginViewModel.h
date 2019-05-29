//
//  LoginViewModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveObjC.h>
#import "Services.h"
#import "User.h"
@interface LoginViewModel : NSObject

@property (strong, nonatomic) User *user;
@property (strong, nonatomic) RACCommand *loginCommand;

+ (instancetype)loginViewModelWithUser:(User *)user;
- (instancetype)initWithUser:(User *)user;
@end
