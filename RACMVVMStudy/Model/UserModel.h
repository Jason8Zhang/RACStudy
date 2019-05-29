//
//  UserModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (assign, nonatomic, getter=isLogined) BOOL logined;

+ (instancetype)userModelWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;
@end
