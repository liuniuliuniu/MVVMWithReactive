//
//  ViewController.m
//  Reactive Demo
//
//  Created by liushaohua on 2016/12/31.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

// Controller
#import "ViewController.h"
#import "detailVC.h"

// Model
#import "VCViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (nonatomic, strong)VCViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self uppercaseString];
//    [self signalSwitch];
//    [self combiningLatest];
//    [self merge];
    
    
    [self bindModel];
    [self onClick];
    
}

// 关联 ViewModel
- (void)bindModel{
    _viewModel = [VCViewModel new];
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, passWord) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [_viewModel buttonIsVaild];
    
//    @weakify(self);
    // 成功要处理的方法
    [self.viewModel.successObject subscribeNext:^(NSArray * x) {
//        @strongify(self);
        detailVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"detailVC"];
        vc.userName = x[0];
        vc.password = x[1];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    // 失败
    [self.viewModel.failureObject subscribeNext:^(id x) {
        
    }];
    [self.viewModel.errorObject subscribeNext:^(id x) {
        
    }];

}

// 点击登录按钮
- (void)onClick{
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [_viewModel Login];
        
    }];
}

//- (void)dealloc{
//    NSLog(@"%s",__func__);
//}
//









// 信号的合并
- (void)merge{

    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    [[RACSignal merge:@[letters,numbers,chinese]] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [chinese sendNext:@"B"];




}



// 信号量的合并
- (void)combiningLatest{
    // 创建两个自定义信号量
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    [[RACSignal combineLatest:@[letters,numbers] reduce:^(NSString *letters, NSString *numbers){
        return  [letters stringByAppendingString:numbers];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@",x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];





}



// 信号开关
- (void)signalSwitch{
    // 自定义信号量
    RACSubject *google = [RACSubject subject];
    RACSubject *baidu = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
    
    // 获取开关信号
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    
    // 对通过开关的信号量进行操作
    
    [[switchSignal map:^id(NSString * value) {
        return [@"https//www."stringByAppendingFormat:@"%@",value];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"%@",x);
    }];
    
    // 通过开关打开百度 和谷歌
    [signalOfSignal sendNext:baidu];
    [baidu sendNext:@"baidu.com"];
    [baidu sendNext:@"baidu.com/"];

    [signalOfSignal sendNext:google];
    [google sendNext:@"google.com"];
    [google sendNext:@"google.com/"];

}






// 转换大小写  signal 和 map
- (void)uppercaseString{
//    // 数组
    NSArray *arr1 = @[@"you",@"are",@"beautiful"];
//    // 将数组生成 RAC 中的队列
//    RACSequence *sequence = [arr1 rac_sequence];
//    // 获取给队列对象的信号量
//    RACSignal *signal = sequence.signal;
//    // 调用 Map 的方法 是每一个首字母大写
//    RACSignal *capitalizedSignal = [signal map:^id(NSString * value) {
//        return [value capitalizedString];
//    }];
//    // 遍历原来的信号量
//    [signal subscribeNext:^(NSString * x) {
//        NSLog(@"signal --- %@",x);
//    }];
//    
//    // 遍历转换后的信号量
//    [capitalizedSignal subscribeNext:^(NSString * x) {
//        NSLog(@"capitalizedSignal --- %@",x);
//    }];
//-------以上可以简化为下边代码----------
    
    [[[arr1 rac_sequence].signal map:^id(NSString * value) {
        return [value capitalizedString];
    }] subscribeNext:^(NSString * x) {
        NSLog(@"capitalizedString------%@",x);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
