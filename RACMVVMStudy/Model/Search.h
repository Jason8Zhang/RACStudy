//
//  Search.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "Services.h"

@interface Search : NSObject
/**
 搜索文字
 */
@property (copy, nonatomic) NSString *searchText;
@property (strong, nonatomic, readonly) Services *services;
@property (strong, nonatomic, readonly) UserModel *userModel;

+ (instancetype)searchWithServices:(Services *)services userModel:(UserModel *)model;
- (instancetype)initWithServices:(Services *)services userModel:(UserModel *)model;

@end
