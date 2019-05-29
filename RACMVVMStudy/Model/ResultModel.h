//
//  ResultModel.h
//  MVVMRACStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject
@property (assign, nonatomic) BOOL success;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) id dataModel;

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)model;
- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)model;
@end
