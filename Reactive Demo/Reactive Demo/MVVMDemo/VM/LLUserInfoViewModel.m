//
//  LLUserInfoViewModel.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLUserInfoViewModel.h"

#import "LLUser.h"
#import "LLUserAPIManager.h"

@interface LLUserInfoViewModel ()

@property (nonatomic,assign) NSUInteger userID;

@end


@implementation LLUserInfoViewModel


+ (instancetype)viewModelWithUserID:(NSUInteger)userID{
    
    LLUserInfoViewModel *viewModel = [LLUserInfoViewModel new];
    
    viewModel.userID = userID;
    
    return viewModel;
}


- (RACCommand *)fetchUserInfoCommand{


    return [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        // donext 返回的还是信号
        return [[self fetchUserInfoSignal] doNext:^(LLUser * user) {
          
            self.user = user;
            self.icon = [UIImage imageNamed:user.icon ?:@"user"];
            self.name = user.name.length > 0 ? user.name : @"奥卡姆剃须刀";
            self.summary = [NSString stringWithFormat:@"个人简介%@",user.summary.length > 0 ? user.summary : @"什么都没写"];
            self.blogCount = [NSString stringWithFormat:@"作品%ld",user.blogCount];
            self.friendCount = [NSString stringWithFormat:@"好友:%ld",user.friendCount];
        }];
    }];
}

- (RACSignal *)fetchUserInfoSignal{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[LLUserAPIManager new]fetchUserInfoWithUserId:self.userID completionHandler:^(NSError *error, LLUser * user) {
           
            if (!error) {
                [subscriber sendNext:user];
                [subscriber sendCompleted];
            }else{
            
                [subscriber sendError:error];
            
            }
            
        }];
        
        return nil;
        
    }];

}




@end
