//
//  LLUserAPIManager.h
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NetworkCompletionHandler)(NSError *error, id result);


typedef enum : NSUInteger {
    NetWorkErrorNoData,
    NetWorkErrorNoMoreData
} NetWorkError;


@interface LLUserAPIManager : NSObject


//  模拟请求数据
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;

- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;

- (void)loadModeUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler;

- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)completionHandler;



@end
