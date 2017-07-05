//
//  LLBlogVIewModel.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLUserAPIManager.h"
#import "LLBlogCellVIewModel.h"

@interface LLBlogVIewModel : NSObject

+ (instancetype)viewModelWithUserID:(NSUInteger)userID;


- (NSArray<LLBlogCellVIewModel *> *)allDatas;


@property(nonatomic, strong)RACSignal *refreshDataSignal;

@property(nonatomic, strong)RACSignal *loadMoreDataSignal;


@end
