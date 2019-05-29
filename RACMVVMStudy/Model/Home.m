//
//  Home.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "Home.h"
#import "FriendModel.h"

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
//
//- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count {
//    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        
//        return nil
//    }];
//}
//- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count {
//
//}
@end
