//
//  LLMVVMUserViewController.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLMVVMUserViewController.h"
#import "LLBlogView.h"
#import "LLUserInfoController.h"

#import "LLUser.h"

#import "UIView+Alert.h"
#import "UIView+Extension.h"
#import "UIResponder+Router.h"


@interface LLMVVMUserViewController ()

@property (nonatomic,assign) NSUInteger userID;

@property(nonatomic, strong)LLBlogView *blogView;

@property(nonatomic, strong)LLUserInfoController *userInfoController;


@end

@implementation LLMVVMUserViewController

+ (instancetype)initWithUserID:(NSUInteger)userID{

    return [[self alloc]initWithUserID:userID];

}

- (instancetype)initWithUserID:(NSUInteger)userID{

    if (self = [super init]) {
        self.userID = userID;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self configuration];
    
    [self setupUI];
    
    [self fetchData];
    
}

- (void)routeEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    
    NSLog(@"%@----%@ ",eventName,userInfo);
    
    if ([eventName isEqualToString:LikeBlogEvent]) {
        
        LLBlogCellVIewModel *viewModel = userInfo[kCellViewModel];
        
        if (!viewModel.isLiked) {
            
            
            [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError *error) {
               
                [self showToastWithText:error.domain];
                
            }];
        }else{
            
            [self showAlertWithTitle:@"提示" message:@"确认取消点赞吗？" confirmHandler:^(UIAlertAction *confirmAction) {
               
                [[viewModel.likeBlogCommand execute:nil] subscribeError:^(NSError *error) {

                    [self showToastWithText:error.domain];
                    
                }];
            }];
    }
    }
    
}


- (void)configuration{
    
    self.title = @"MVVMDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 在此控制器中绑定数据
    self.userInfoController = [LLUserInfoController initWithView:[LLUserInfoView new] viewModel:[LLUserInfoViewModel viewModelWithUserID:self.userID]];
    
    
    @weakify(self);
    self.userInfoController.onClickIconCommond = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(LLUser *user) {
        @strongify(self);
        
        [self showToastWithText:[NSString stringWithFormat:@"跳转至控制器%@",user.name]];
        
        return [RACSignal empty];
    }];
    
    // 博客的tableview
    self.blogView = [LLBlogView blogViewWithViewModel:[LLBlogVIewModel viewModelWithUserID:self.userID]];
    
    
    self.blogView.didSelectCommand  = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
       
        @strongify(self);
        
        [self showToastWithText:@"进入博客详情页"];
        
        return [RACSignal empty];
    }];
    

}

- (void)setupUI{
    
    self.userInfoController.view.frame = CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, 160);
    [self.view addSubview:self.userInfoController.view];
    
    self.blogView.tableView.frame = CGRectMake(0, self.userInfoController.view.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.userInfoController.view.bottom);
    
    [self.view addSubview:self.blogView.tableView];

}

- (void)fetchData{
    
    [self.userInfoController fetchData];
    
    [self showHUD];
    
    [[self.blogView.fetchDataCommand execute:nil] subscribeNext:^(id x) {
       
        [self hideHUD];
        
    }completed:^{
        
        [self hideHUD];
        
    }];
    



}






@end
