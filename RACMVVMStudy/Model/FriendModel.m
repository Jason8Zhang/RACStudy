//
//  FriendModel.m
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "FriendModel.h"

@implementation FriendModel
+ (instancetype)friendModelWithInfo:(NSDictionary *)info {
    return [[self alloc] initWithInfo:info];
}
- (instancetype)initWithInfo:(NSDictionary *)info {
    if (self = [super init]) {
        self.uin = [info[@"uin"] stringValue];
        self.name = info[@"name"];
        self.img = info[@"img"];
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"uin: %@, name: %@, image: %@", self.uin, self.name, self.img];
}
@end
