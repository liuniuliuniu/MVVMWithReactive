//
//  LLBlogCellVIewModel.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLBlogCellVIewModel.h"



NSString *LikeBlogEvent = @"LikeBlogEvent";
NSString *kCellViewModel = @"kCellViewModel";

@interface LLBlogCellVIewModel ()

@property (strong, nonatomic) LLBlog *blog;
@property (strong, nonatomic) RACCommand *likeBlogCommand;

@end


@implementation LLBlogCellVIewModel

+ (instancetype)viewModelWithBlog:(LLBlog *)blog{

    return [[LLBlogCellVIewModel alloc]initWithBlog:blog];
}


- (instancetype)initWithBlog:(LLBlog *)blog{
    
    if (self = [super init]) {
        
        self.blog = blog;
        
        @weakify(self);
        
        self.likeBlogCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            RACSubject *subject = [RACSubject subject];
            
            // 是否点赞
            if (self.isLiked) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    self.isLiked = NO;
                    self.blogLikeCount = self.blog.likeCount - 1;
                    [subject sendCompleted];
                    
                });
            }else{
                
                self.isLiked = YES;
                self.blogLikeCount = self.blog.likeCount + 1;
                [[LLUserAPIManager new] likeBlogWithBlogId:self.blog.blogId completionHandler:^(NSError *error, id result) {
                    if (!error) {
                        
                        self.isLiked = NO;
                        self.blogLikeCount = self.blog.likeCount - 1;
                    }
                    error ? [subject sendError:error] : [subject sendCompleted];
                }];
            }
            
            return subject;
            
        }];
    }
    
    return self;

}

#pragma mark - getters and setters

- (BOOL)isLiked{
    return self.blog.isLiked;
}


- (void)setIsLiked:(BOOL)isLiked{
    self.blog.isLiked = isLiked;
}



- (NSString *)blogTitleText{

    return self.blog.blogTitle.length > 0 ? self.blog.blogTitle : @"未命名";

}


- (NSString *)blogSummaryText{
    
    return self.blog.blogSummary.length > 0 ? self.blog.blogSummary : @"这个人很懒什么也没写";

}

- (NSString *)blogLikeCount{

    return [NSString stringWithFormat:@"赞 %ld",self.blog.likeCount];

}

- (void)setBlogLikeCount:(NSInteger)likeCount{

    self.blog.likeCount = likeCount;

}

- (NSString *)blogShareCount{

    return [NSString stringWithFormat:@"分享 %ld",self.blog.shareCount];

}



@end
