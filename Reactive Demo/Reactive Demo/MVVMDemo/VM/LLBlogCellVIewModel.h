//
//  LLBlogCellVIewModel.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLBlog.h"
#import "LLUserAPIManager.h"



extern NSString *LikeBlogEvent;
extern NSString *kCellViewModel;


@interface LLBlogCellVIewModel : NSObject


+ (instancetype)viewModelWithBlog:(LLBlog *)blog;

- (LLBlog *)blog;

- (BOOL)isLiked;
- (NSString *)blogTitleText;
- (NSString *)blogSummaryText;
- (NSString *)blogLikeCount;
- (NSString *)blogShareCount;

- (RACCommand *)likeBlogCommand;
//- (RACCommand *)shareBlogCommand;




@end
