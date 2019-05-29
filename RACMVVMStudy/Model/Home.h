//
//  Home.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Home : NSObject
@property (strong, nonatomic, readonly) User *user;

+ (instancetype)homeWithUser:(User *)user;
- (instancetype)initWithUser:(User *)user;

- (RACSignal *)friendSignalWithPage:(NSInteger)page andCount:(NSInteger)count;
- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count;
@end
