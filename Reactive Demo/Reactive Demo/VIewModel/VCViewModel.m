//
//  VCViewModel.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/1/2.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "VCViewModel.h"

@interface VCViewModel ()
// 存储用户名和密码的信号量
@property (nonatomic, strong)RACSignal *userNameSignal;

@property (nonatomic, strong)RACSignal *passWordSignal;
// 网络请求返回的数据
@property (nonatomic, strong)NSArray *requestData;

@end

@implementation VCViewModel

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self setupUI];
    }

    return self;
}
#pragma mark - 初始化属性
- (void)setupUI
{
    _userNameSignal = RACObserve(self, userName);
    _passWordSignal = RACObserve(self, passWord);
    _successObject = [RACSubject subject];
    _failureObject = [RACSubject subject];
    _errorObject = [RACSubject subject];
}
#pragma mark - 合并两个输入框的信号 并返回按钮 bool 类型的值
- (id)buttonIsVaild{
    
    RACSignal *isVaild = [RACSignal combineLatest:@[_userNameSignal,_passWordSignal] reduce:^id(NSString *userName,NSString *passWord){
        return @(userName.length >= 3 && passWord.length >= 3);
    }];
    return isVaild;
}

#pragma mark - 模型网络请求  返回数据 发送成功信号
- (void)Login{
    _requestData = @[_userName,_passWord];
    // 成功发送成功的信号
    [_successObject sendNext:_requestData];
}

@end
