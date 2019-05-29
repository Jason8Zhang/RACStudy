//
//  Results.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Results : NSObject
@property (strong, nonatomic, readonly) User *user;

+ (instancetype)resultWithUser:(User *)user;
- (instancetype)initWithUser:(User *)user;
- (RACSignal *)searchSignalWithContent:(NSString *)content page:(NSInteger)page andCount:(NSInteger)count;
@end
