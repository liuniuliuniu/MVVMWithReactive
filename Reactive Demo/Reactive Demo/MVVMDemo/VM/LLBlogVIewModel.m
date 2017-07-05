//
//  LLBlogVIewModel.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLBlogVIewModel.h"
#import "LLBlog.h"


@interface LLBlogVIewModel ()

@property (nonatomic,assign) NSUInteger userID;

@property (nonatomic, strong) LLUserAPIManager *apiManager;

@property (nonatomic, strong)NSMutableArray<LLBlogCellVIewModel *> *blogs;


@end

@implementation LLBlogVIewModel

+ (instancetype)viewModelWithUserID:(NSUInteger)userID{
    
    return [[self alloc]initWithUserID:userID];

}


- (instancetype)initWithUserID:(NSUInteger)userID{

    if (self = [super init]) {
        self.blogs = [NSMutableArray array];
        self.userID = userID;
        self.apiManager = [LLUserAPIManager new];
        
        @weakify(self);
        
        self.refreshDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            [self.apiManager refreshUserBlogsWithUserId:userID completionHandler:^(NSError *error, id result) {
               
                if (!error) {
                    
                    [self.blogs removeAllObjects];
                    [self formatResult:result];
                    
                }
                
                error ? [subscriber sendError:error]: [subscriber sendCompleted];
           
            }];
            
            return nil;
        }];
        
        self.loadMoreDataSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           @strongify(self);
            
            [self.apiManager loadModeUserBlogsWithUserId:self.userID completionHandler:^(NSError *error, id result) {
            
                error ?: [self formatResult:result];
                error ? [subscriber sendError:error] : [subscriber sendCompleted];
                
            }];
        
            return nil;
        }];
    }
    
    
    return self;
}


- (NSArray<LLBlogCellVIewModel *> *)allDatas{

    return self.blogs;
}

- (void)formatResult:(NSArray *)blogs{
    
    for (LLBlog *blog in blogs) {
        [self.blogs addObject:[LLBlogCellVIewModel viewModelWithBlog:blog]];
    }
}


@end
