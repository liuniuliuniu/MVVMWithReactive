//
//  LLBlogView.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "LLBlogVIewModel.h"

@interface LLBlogView : NSObject<UITableViewDelegate,UITableViewDataSource>


+ (instancetype)blogViewWithViewModel:(LLBlogVIewModel *)viewModel;


- (UITableView *)tableView;


@property(nonatomic, strong)RACCommand *fetchDataCommand;

@property(nonatomic, strong)RACCommand *didSelectCommand;


@end
