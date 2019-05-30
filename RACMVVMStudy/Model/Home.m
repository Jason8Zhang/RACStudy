//
//  Home.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "Home.h"
#import "FriendModel.h"
#import "ResultModel.h"
#import "LinqToObjectiveC.h"
@implementation Home
+ (instancetype)homeWithUser:(User *)user {
    return [[self alloc] initWithUser:user];
}
- (instancetype)initWithUser:(User *)user {
    if (self = [super init]) {
        _user = user;
    }
    
    return self;
}
- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count {
    return [[self.user.services friendSignalWithPage:page andCount:count] map:^id _Nullable(Result *result) {
        //转换为模型数据
        return [ResultModel resultWithSuccess:result.success message:result.message dataModel:[result.responseObject linq_select:^id(id item) {
            return [FriendModel friendModelWithInfo:item];
        }]];
    }];
}
- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count {
    return [[self.user.services searchSignalWithContent:content page:page andCount:count] map:^id _Nullable(Result *result) {
        //转换为模型数据
        return [ResultModel resultWithSuccess:result.success message:result.message dataModel:[result.responseObject linq_select:^id(id item) {
            return [FriendModel friendModelWithInfo:item];
        }]];
    }];
}
@end
