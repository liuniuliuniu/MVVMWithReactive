//
//  DetailViewController.m
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [RACObserve(self.textFiled,center ) subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    
    
//    RAC(self.label,text) = self.textFiled.rac_textSignal;
    
    
    
//    [self.textFiled.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//
    
    
    // 正确的写法 1  这个写法 当dealloc信号发出的时候 就释放通知
//    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
//        
//        NSLog(@"键盘弹出");
//        
//    }];

    
    // 正确的写法2
    
    
//    RACSignal *deallocSignal = [self rac_signalForSelector:@selector(viewWillDisappear:)];
//    
//    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:deallocSignal] subscribeNext:^(id x) {
//        NSLog(@"键盘弹出%@",x);
//    }];
//    
//    
    
    
    // 错误的 写法
//    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
//        
//        NSLog(@"%@",x);
//        
//    }];
//    

    
    
}




- (IBAction)delegateBtn:(id)sender {
    
    if (self.delagateSignal) {
        // 发送信号
        [self.delagateSignal sendNext:@"我是从详情里边出来的哈哈"];
    }
    
}

@end
