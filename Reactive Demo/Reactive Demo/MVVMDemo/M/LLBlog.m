//
//  LLBlog.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLBlog.h"

@implementation LLBlog

- (instancetype)initWithBlogId:(NSUInteger)blogId {
    
    self.blogId = blogId;
    self.isLiked = blogId % 2;
    self.likeCount = blogId + 10;
    self.blogTitle = [NSString stringWithFormat:@"blogTitle%ld", blogId];
    self.shareCount = blogId + 8;
    self.blogSummary = [NSString stringWithFormat:@"blogSummary%ld", blogId];
    
    return self;
}


@end
