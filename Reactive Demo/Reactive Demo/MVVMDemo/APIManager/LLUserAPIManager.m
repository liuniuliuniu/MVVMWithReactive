//
//  LLUserAPIManager.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLUserAPIManager.h"

#define PageSize 20

#import "LLUser.h"
#import "LLBlog.h"


@interface LLUserAPIManager ()

@property (assign, nonatomic) NSUInteger blogPage;

@end

@implementation LLUserAPIManager

//请求用户信息
- (void)fetchUserInfoWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completionHandler ?: completionHandler(nil, [[LLUser alloc] initWithUserId:userId]);
    });
}



//加载blog
- (void)refreshUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.blogPage = 0;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}




// 刷新blog
- (void)loadModeUserBlogsWithUserId:(NSUInteger)userId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    self.blogPage += 1;
    [self fetchUserBlogsWithUserId:userId page:self.blogPage pageSize:PageSize completionHandler:completionHandler];
}



// 点赞
- (void)likeBlogWithBlogId:(NSUInteger)blogId completionHandler:(NetworkCompletionHandler)completionHandler {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSError *error = arc4random() % 2 ? [NSError errorWithDomain:@"点赞失败" code:123 userInfo:nil] : nil;
        
        !completionHandler ?: completionHandler(error, nil);
    });
}


- (void)fetchUserBlogsWithUserId:(NSUInteger)userId page:(NSUInteger)page pageSize:(NSUInteger)pageSize completionHandler:(NetworkCompletionHandler)completionHandler {
    
    NSUInteger delayTime = page == 0 ? 1.5 : 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if (page >= 2) {
            !completionHandler ?: completionHandler([NSError errorWithDomain:@"没有更多了" code:NetWorkErrorNoMoreData userInfo:nil], nil);
        } else {
            
            NSMutableArray *blogs = [NSMutableArray array];
            for (int i = 0; i < pageSize; i ++) {
                
                [blogs addObject:[[LLBlog alloc] initWithBlogId:pageSize * page + i]];
            }
            !completionHandler ?: completionHandler(nil, blogs);
        }
    });
}





@end
