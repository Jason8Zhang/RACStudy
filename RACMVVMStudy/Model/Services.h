//
//  Services.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
@interface Result : NSObject

@property (assign, nonatomic) BOOL success;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) id responseObject;

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;
- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;

@end

@interface Services : NSObject

- (RACSignal *)loginSignal:(NSString *)userName passWord:(NSString *)passWord;
- (RACSignal *)logoutSignal:(NSString *)userName passWord:(NSString *)passWord;

- (RACSignal *)searchSignal:(NSString *)searchText;
- (RACSignal *)allFriendsSignal;
- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count;
- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count;

@end
