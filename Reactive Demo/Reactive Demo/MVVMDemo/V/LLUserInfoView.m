//
//  LLUserInfoView.m
//  Reactive Demo
//
//  Created by liushaohua on 2017/7/4.
//  Copyright © 2017年 liushaohua. All rights reserved.
//

#import "LLUserInfoView.h"
#import "Masonry.h"

@interface LLUserInfoView ()


@end


@implementation LLUserInfoView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}

- (void)addUI {
    
    UILabel *(^makeLabel)() = ^{
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor whiteColor];
        return label;
    };
    
    
    UIButton *iconButton = [UIButton new];
    [self addSubview:self.iconButton = iconButton];
    
    [self addSubview:self.nameLabel = makeLabel()];
    [self addSubview:self.summaryLabel = makeLabel()];
    [self addSubview:self.blogCountLabel = makeLabel()];
    [self addSubview:self.friendCountLabel = makeLabel()];
    self.summaryLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    [iconButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    CGFloat nameLabelWidth = 240;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconButton.mas_bottom).offset(8);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(nameLabelWidth, 30));
    }];
    
    [self.blogCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(nameLabelWidth * 0.5, 21));
    }];
    
    [self.friendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.blogCountLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(nameLabelWidth * 0.5, 21));
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.blogCountLabel.mas_bottom).offset(8);
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.height.mas_equalTo(30);
    }];
}

@end
