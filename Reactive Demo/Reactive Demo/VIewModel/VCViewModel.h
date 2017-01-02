//
//  VCViewModel.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/1/2.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCViewModel : NSObject

@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *passWord;

// 三个信号量用来返回成功 失败 无网络

@property (nonatomic, strong)RACSubject *successObject;
@property (nonatomic, strong)RACSubject *failureObject;
@property (nonatomic, strong)RACSubject *errorObject;


- (id)buttonIsVaild;
- (void)Login;


@end
