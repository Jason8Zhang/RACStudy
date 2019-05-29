//
//  FriendModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject
@property (copy, nonatomic) NSString *uin;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *img;

+ (instancetype)friendModelWithInfo:(NSDictionary *)info;
- (instancetype)initWithInfo:(NSDictionary *)info;
@end
