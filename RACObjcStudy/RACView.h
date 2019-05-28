//
//  RACView.h
//  RACObjcStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>
#import <Masonry.h>
@interface RACView : UIView
@property(nonatomic,strong) RACSubject *btnClickSingle;

- (void)sendValue:(NSString *)str andDic:(NSDictionary *)dic;
@end
