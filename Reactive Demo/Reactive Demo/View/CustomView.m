//
//  CustomView.m
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "CustomView.h"



@implementation CustomView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
 
    self.backgroundColor = [UIColor greenColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30, 30, 100, 50)];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(TapClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)TapClick{

    if ([self.delegate respondsToSelector:@selector(CustomViewTapClick)]) {
        [self.delegate CustomViewTapClick];
    }

}


@end
