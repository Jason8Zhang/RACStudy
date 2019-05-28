//
//  RACView.m
//  RACObjcStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "RACView.h"

@implementation RACView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *button = [UIButton new];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.left.top.mas_equalTo(self).mas_offset(30);
        }];
        [button setTitle:@"RACSubject" forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.btnClickSingle sendNext:@"按钮点击咯"];
        }];
        
        UIButton *button1 = [UIButton new];
        [self addSubview:button1];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 40));
            make.top.mas_equalTo(self.mas_top).mas_offset(30);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
        }];
        [button1 setTitle:@"rac_signalForSelector" forState:UIControlStateNormal];
        button1.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self sendValue:@"1234" andDic:@{@"key":@"value"}];
        }];
    }
    return self;
}



- (RACSubject *)btnClickSingle {
    if (!_btnClickSingle) {
        _btnClickSingle = [RACSubject subject];
    }
//    _btnClickSingle
    return _btnClickSingle;
}
-(void)sendValue:(NSString *)str andDic:(NSDictionary *)dic{
    
}
@end
