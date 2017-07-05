//
//  LLBlogCell.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/5.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLBlogCell.h"

#import "UIResponder+Router.h"

@interface LLBlogCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end



@implementation LLBlogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    //  绑定数据
    @weakify(self);
    
    RAC(self.titleLabel,text) = RACObserve(self, viewModel.blogTitleText);
    RAC(self.summaryLabel,text) = RACObserve(self, viewModel.blogSummaryText);
    
    // 设置这个选中属性一定要忽略Nil
    RAC(self.likeButton,selected) = [RACObserve(self,viewModel.isLiked)ignore:nil];
            
    [RACObserve(self, viewModel.blogLikeCount) subscribeNext:^(NSString *title) {
        @strongify(self);
        [self.likeButton setTitle:title forState:UIControlStateNormal];
        
    }];
    
    
    [RACObserve(self, viewModel.blogShareCount) subscribeNext:^(NSString * title) {
        @strongify(self);
        [self.shareButton setTitle:title forState:UIControlStateNormal];
    }];
    
        
}

// 传递事件
- (IBAction)onClickLikeButton:(UIButton *)sender {
    
    [self routeEvent:LikeBlogEvent userInfo:@{kCellViewModel : self.viewModel}];
    
}





@end
