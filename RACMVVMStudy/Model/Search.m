//
//  Search.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "Search.h"

@implementation Search
+ (instancetype)searchWithServices:(Services *)services userModel:(UserModel *)model {
    return [[self alloc] initWithServices:services userModel:model];
}
- (instancetype)initWithServices:(Services *)services userModel:(UserModel *)model {
    if (self = [super init]) {
        _services = services;
        _userModel = model;
    }
    
    return self;
}
@end
