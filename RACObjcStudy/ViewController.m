//
//  ViewController.m
//  RACObjcStudy
//
//  Created by apple-new on 2019/5/20.
//  Copyright © 2019 jason. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "RACView.h"

@interface ViewController ()
@property(nonatomic,weak)IBOutlet UILabel *label;
@property(nonatomic,weak)IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (nonatomic,assign)int time;
@property (nonatomic,strong)RACDisposable *disposable;
@property (nonatomic,strong)RACSignal *signal;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self test];
    [self test1];
    [self test2];
    [self test4];
    [self.view bringSubviewToFront:self.textfield];
    [self test5];
    [self test6];
    [self test7];
    [self test8];
    [self test9];
    [self test10];
    [self test11];
    [self test12];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma - mark 按钮事件点击
- (void)test{
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [button setTitle:@"按钮事件点击" forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"----->按钮事件点击 %@",x);
    }];
}


#pragma - mark KVO
- (void)test1{
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).mas_offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    [button setTitle:@"KVO" forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.backgroundColor = [UIColor greenColor];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [UIView animateWithDuration:1 animations:^{
            button.backgroundColor = [UIColor yellowColor];
        }];
    }];
    
    [[button rac_valuesForKeyPath:@"backgroundColor" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"x ----->KVO %@",x);
    }];
}

#pragma - mark RACSubject && rac_signalForSelector
- (void)test2{
    RACView *racView = [RACView new];
    [self.view addSubview:racView];
    [racView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(100);
    }];
    [racView.btnClickSingle subscribeNext:^(id  _Nullable x) {
        NSLog(@"---->RACSubject %@",x);
    }];
    
    [[racView rac_signalForSelector:@selector(sendValue:andDic:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"----->rac_signalForSelector %@",x);
    }];
}

#pragma - mark 通知
- (void)test4{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"----> %@",x);
    }];
}

#pragma - mark textView 输入事件监听
- (void)test5 {
    [self.textfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"--->%@",x);
    }];
}

#pragma - mark timer
- (void)test6{
    [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"timer");
    }];
}


#pragma - mark 倒计时按钮
- (void)test7 {
    [self.testButton setBackgroundColor:[UIColor greenColor]];
    [self.testButton setTitle:@"发送" forState:UIControlStateNormal];
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.time = 10;
        self.testButton.enabled = NO;
        [self.testButton setTitle:[NSString stringWithFormat:@"%d s",self.time] forState:UIControlStateNormal];
        self.disposable = [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
            self.time--;
            NSString *testString = self.time > 0 ? [NSString stringWithFormat:@"%d s",self.time] : @"发送";
            if (self.time > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.testButton.enabled = NO;
                    [self.testButton setTitle:testString forState:UIControlStateNormal];
                });
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.testButton.enabled = YES;
                    [self.testButton setTitle:@"发送" forState:UIControlStateNormal];
//                    [self.disposable dispose];
                });

            }
        }];
    }];
}

#pragma - mark 多个信号一起完成后,再去处理事件
- (void)test8 {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
         sleep(20);
        NSLog(@"发送请求1");
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求2
        sleep(2);
         NSLog(@"发送请求2");
        [subscriber sendNext:@"发送请求2"];
        
        return nil;
    }];
    
    // 使用注意：几个信号，selector的方法就几个参数，每个参数对应信号发出的数据。
    // 不需要订阅:不需要主动订阅,内部会主动订阅
    
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignals:signal1,signal2, nil];
}
// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@ %@",data,data1);
}

#pragma - mark RACObserve宏
- (void)test9 {
    // RACObserve(就是一个宏定义):快速的监听某个对象的某个属性改变
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40));
        make.left.centerY.mas_equalTo(self.view);
    }];
    button.backgroundColor = [UIColor yellowColor];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [UIView animateWithDuration:1 animations:^{
            [button mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(40, 80));
            }];
            button.backgroundColor = [UIColor purpleColor];
        }];
    }];
    
    [RACObserve(button,frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"x ----->RACObserve宏 %@",x);
    }];
}

#pragma - mark RAC宏
- (void)test10 {
    //用来给某个对象的某个属性绑定信号，只要产生信号内容，就会把内容给属性赋值
    RAC(self.label,text) = self.textfield.rac_textSignal;
}

#pragma - mark 登陆密码框
- (void)test11 {
    //登录按钮的状态根据账号和密码输入框内容的长度来改变
    
    UITextField *userNameTF = [UITextField new];
    UITextField *passwordTF = [UITextField new];
    [self.view addSubview:userNameTF];
    [self.view addSubview:passwordTF];
    [userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.center.mas_equalTo(self.view);
    }];
    
    [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNameTF.mas_bottom).mas_offset(30);
        make.size.centerX.mas_equalTo(userNameTF);
    }];
    userNameTF.placeholder = @"请输入用户名";
    passwordTF.placeholder = @"请输入密码";

    UIButton *loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.top.mas_equalTo(passwordTF.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(passwordTF.mas_centerX);
    }];
    [loginBtn setTitle:@"马上登录" forState:UIControlStateNormal];
    
    RAC(loginBtn,backgroundColor) = [RACSignal combineLatest:@[userNameTF.rac_textSignal,passwordTF.rac_textSignal] reduce:^id _Nonnull(NSString *username,NSString *password){
        if (username.length > 0 && password.length > 0) {
            return [UIColor redColor];
        } else {
            return [UIColor greenColor];
        }
    }];
    
    [[userNameTF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 6;
    }]subscribeNext:^(NSString * _Nullable x) {
        userNameTF.backgroundColor = [UIColor greenColor];
    }];

    RAC(loginBtn,enabled) = [RACSignal combineLatest:@[userNameTF.rac_textSignal,passwordTF.rac_textSignal] reduce:^id _Nonnull(NSString *username,NSString *password){
        return @(username.length > 0 && password.length > 0);
    }];
}

#pragma -mark 弱引用宏
-(void)test12{
    //避免循环引用，外部@weakify(self)，内部@strongify(self)
    // @weakify() 宏定义
    @weakify(self) //相当于__weak typeof(self) weakSelf = self;
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)  //相当于__strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",self.view);
        return nil;
    }];
    _signal = signal;
}

@end
