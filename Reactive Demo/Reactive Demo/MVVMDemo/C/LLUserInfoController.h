//
//  LLUserInfoController.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLUserInfoView.h"
#import "LLUserInfoViewModel.h"

@interface LLUserInfoController : NSObject

+ (instancetype)initWithView:(LLUserInfoView *)view viewModel:(LLUserInfoViewModel *)viewModel;

@property(nonatomic, strong)LLUserInfoView *view;

@property(nonatomic, strong)LLUserInfoViewModel *viewModel;

@property(nonatomic, strong)RACCommand *onClickIconCommond;

- (void)fetchData;

@end
