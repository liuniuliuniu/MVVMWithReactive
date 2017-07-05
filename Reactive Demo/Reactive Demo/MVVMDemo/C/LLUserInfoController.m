//
//  LLUserInfoController.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLUserInfoController.h"


@implementation LLUserInfoController

+ (instancetype)initWithView:(LLUserInfoView *)view viewModel:(LLUserInfoViewModel *)viewModel{
    
    if (view == nil || viewModel == nil) return nil;
    
    return [[self alloc]initWithVIew:view viewModel:viewModel];
    
}


- (instancetype)initWithVIew:(LLUserInfoView *)view viewModel:(LLUserInfoViewModel *)viewModel{
    
    if (self = [super init]) {
        self.view = view;
        self.viewModel = viewModel;
        
        [self bindData];
    }
    return self;
}

- (void)bindData{
    
    // 字符串直接绑定
    RAC(self.view.nameLabel,text) = RACObserve(self, viewModel.name);
    RAC(self.view.summaryLabel,text) = RACObserve(self, viewModel.summary);
    RAC(self.view.blogCountLabel,text) = RACObserve(self, viewModel.blogCount);
    RAC(self.view.friendCountLabel,text) = RACObserve(self, viewModel.friendCount);
    
    @weakify(self);
    // 图像
    [RACObserve(self, viewModel.icon) subscribeNext:^(UIImage *icon) {
        @strongify(self);
        [self.view.iconButton setImage:icon forState:UIControlStateNormal];
    }];
    
    
    // 点击事件发送个人详情
    [[self.view.iconButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self);
        
        [self.onClickIconCommond execute:self.viewModel.user];
        
    }];
    
}

- (void)fetchData{
    
    [[[self.viewModel fetchUserInfoCommand] execute:nil] subscribeNext:^(id x) {
        
    }completed:^{
        
    }];

}




@end
