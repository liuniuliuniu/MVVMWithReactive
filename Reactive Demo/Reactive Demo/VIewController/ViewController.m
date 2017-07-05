//
//  ViewController.m
//  Reactive Demo
//
//  Created by liushaohua on 2016/10/20.
//  Copyright © 2016年 liushaohua. All rights reserved.
//

// Controller
#import "ViewController.h"
#import "DetailViewController.h"
#import "PeopleModel.h"
#import "LLMVVMUserViewController.h"
#import "CustomView.h"


@interface ViewController ()<CustomViewDelagate>

@property (weak, nonatomic) IBOutlet UIButton *signalBtn;


@end

@implementation ViewController


- (IBAction)pushMVVMDemo:(id)sender {
    
    
    LLMVVMUserViewController *MVVMVC = [LLMVVMUserViewController initWithUserID:123];
    
    [self.navigationController pushViewController:MVVMVC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
//    [self RACSignalDemo1];

    
//    [self RACSubjectDemo];
    
    
//    [self RACReplySubjectDemo];
    
    
    
//    [self RACSequenceAndRACTuple];
    
//    [self dictToModel];
    
    
//    [self RACCommandDemo];
    
    
//    [self RACMulticastConnectionDemo];
          
    
//    [self hongDemo];
    
//    [self moreRequest];
    
//    [self timer];
    
    [self tuple];

}



- (void)tuple{

    
    // 把参数中的数据包装成元祖
    RACTuple *tuple = RACTuplePack(@10,@20,@30);
    
    // 要一一对应付
    RACTupleUnpack(NSString *name,NSString *name2,NSString *name3) = tuple;
    
    NSLog(@"%@---%@---%@",name,name2,name3);


}

- (void)timer{

    
    // 延时执行
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
       
        NSLog(@"2秒后执行我");
        
    }];
    
    // 定时执行  takeUntil 要条件限制一下 否则当控制器销毁后 还是会继续执行
    [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        NSLog(@"每隔1s会执行");
    }];
    
    

    
}



- (void)moreRequest{
    
    
    
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [subscriber sendNext:@"我是数据 - 1"];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
    
    
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"我是数据 - 2"];
            [subscriber sendCompleted];
        });
        return nil;
    }];
    
    
    // 前边的方法参数和后边信号的数据是一一对应的
    [self rac_liftSelector:@selector(reloadData1:Data2:) withSignalsFromArray:@[request1,request2]];
    
}

- (void)reloadData1:(id)Data1 Data2:(id)Data2{

    NSLog(@"ReloadData%@---%@",Data1,Data2);

}


- (void)hongDemo{
    
    // 代替代理
    
    CustomView *V = [[CustomView alloc]initWithFrame:CGRectMake(70, 20, 200, 100)];
    V.backgroundColor = [UIColor redColor];
    [self.view addSubview:V];
    
    V.delegate = self;
    
    
    [[V rac_signalForSelector:@selector(TapClick)] subscribeNext:^(id x) {
        NSLog(@"点击了视图中的按钮%@",x);
    }];
    
    
    // 监听事件
    [[self.signalBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        // 传递的btn
        NSLog(@"点击了按钮%@",x);
        
    }];
    
}


- (void)TapClick{

    

}

- (void)RACMulticastConnectionDemo{
    
//    
//    // 1 创建请求信号
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSLog(@"发送请求");
//        [subscriber sendNext:@1];
//        return nil;
//        
//    }];
//    
//    // 2 订阅信号
//    [signal subscribeNext:^(id x) {
//       
//        NSLog(@"接受数据1");
//        
//    }];
//    
//    // 3 再次订阅信号
//    [signal subscribeNext:^(id x) {
//       
//        NSLog(@"接收数据2");
//        
//    }];
//    
//    // 4 运行结果 会执行两遍发送请求  也就是每次订阅都会发送一次请求
//    
    
    
//    RACMulticastConnection 解决重复请求的问题
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        NSLog(@"发送请求");
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    
    // 2 创建链接
    RACMulticastConnection *connect = [signal publish];
    
    // 3 订阅信号
    
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"接受数据 1 --%@",x);
    }];
    
    [connect.signal subscribeNext:^(id x) {
       
        NSLog(@"接受数据 2 -- %@",x);
        
    }];
    
    // 4 链接 激活信号
    [connect connect];
    
}


- (void)RACCommandDemo{

    
    // RACCommand使用步骤
    // 1 创建命令
    // 2 在signalBlock中 创建信号signal 作为signalblock的返回值
    // 3 执行命令 execute
    
    // RACCommand 使用注意
    // 1 signalBlock 必须返回一个信号 不能返回nil  不过可以传一个空信号 [RACSignal empty];
    // 2 RACCommand 中信号如果数据传递完 必须调用 [subscriber sendCompleted];这是命令才会执行完毕 否则一直在执行过程中
    // 3 comman 需要强引用
    
    // RACCommand的设计思想  signalBlock内部为什么要返回一个信号 这个信号有什么用呢
    // 1 在RAC开发中 通常会把网络请求封装在RACCommand  直接执行某个command就能发送请求
    // 2 在RACCommand内部请求道数据的时候 需要把请求的数据传递给外界这时候就需要signalblock返回的信号传递了
    
    
    
    // 如何拿到command中返回信号发出的数据
    // 1 RACCommand 有一个执行信号源executionSignals  这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2 订阅executionSignals 就能拿到RACCommand中返回的信号 然后订阅signalblock返回的信号 就能获取发出的值
    
    // 监听当前命令是否正在执行executing
    
    // 使用场景 监听按钮的点击 网络请求
    
    
    // 1 创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
      
        
        
        NSLog(@"执行命令%@",input);
        
        // 2 创建信号  用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
            // 在这里边发送网络请求 然后将请求道的结果数据返回给外界
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"我是数据"];
                
                // 发送信号完成后 要发送完成
                [subscriber sendCompleted];
            });
            
            
//            // 发送信号
//            [subscriber sendNext:@"123"];
//            
//            [subscriber sendNext:@"456"];
//            
//            [subscriber sendNext:@"789"];
            
            
            return nil;
        }];
    }];

    
    // 3 订阅RACCommand的信号 在此处可以拿到网络请求回来的数据
    [command.executionSignals subscribeNext:^(id x) {
       
        [x subscribeNext:^(id x) {
            
            NSLog(@"----%@",x);
            
        }];
        
    }];
    
    
    // RAC 的高级用法
    //switchToLatest  用于signal of signals  获取 signal of signals 发出的最新信号也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"switchToLatest---%@",x);
        
    }];
    
    // 4 监听命令是否执行完毕  默认会来一次 可以直接跳过 skip表示跳过信号
    [[command.executing skip:1] subscribeNext:^(id x) {
    
        if ([x boolValue] == YES) {
            
            NSLog(@"正在执行");
            
        }else{
            
            NSLog(@"执行完毕");
        
        }
        
    }];
    
    // 5 执行命令 执行命令的时候 会调用command的block  订阅信号时  block中的信号才能发送出去
    [command execute:@1];
    
    

}



- (void)dictToModel{

////     OC写法
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"PeopleList.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:dictArr.count];
//    
//    for (NSDictionary *dict in dictArr) {
//        
//        PeopleModel *model = [PeopleModel peopleWithDict:dict];
//        [modelArr addObject:model];
//    }
    
    
    //  RAC写法
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"PeopleList.plist" ofType:nil];
//    
//    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray *modelArr = [NSMutableArray arrayWithCapacity:dictArr.count];
//    
//    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
//       
//        PeopleModel *model = [PeopleModel peopleWithDict:x];
//        
//        [modelArr addObject:model];
//        
//    }];
    
    //  RAC高级写法
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"PeopleList.plist" ofType:nil];
    
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];

    
    NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
        
        return [PeopleModel peopleWithDict:value];
        
    }]array];
    
    NSLog(@"%@",[dictArr.rac_sequence map:^id(id value) {
        
        return [PeopleModel peopleWithDict:value];
        
    }]);
    
}


- (void)RACSequenceAndRACTuple{
    
    
//     1 遍历数组
//    NSArray *arr = @[@1,@2,@3,@4,@5];
//    [arr.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    
    // 2 遍历字典
    NSDictionary *dict = @{@"name":@"奥卡姆剃须刀",
                           @"age":@"25",
                           @"location":@"beijing"
                           };
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * x) {
        
        // 解包元祖 会把元祖的值 按顺序给参数里边的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        NSLog(@"%@----%@",key,value);
        
    }];
    

}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *detailVC = segue.destinationViewController;
    
    // 实例化
    detailVC.delagateSignal = [RACSubject subject];    
    // 订阅信号
    [detailVC.delagateSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}


- (void)RACReplySubjectDemo{

    // 1 创建信号
    RACReplaySubject *replySubject = [RACReplaySubject subject];
    
    // 2 发送信号
    [replySubject sendNext:@"我是ReplySubject -- 1"];
    [replySubject sendNext:@"我是ReplySubject -- 2"];
    
    // 3 订阅信号
    [replySubject subscribeNext:^(id x) {
        
        NSLog(@"第一个订阅者接收到的数据%@",x);
        
    }];
    
    
    [replySubject subscribeNext:^(id x) {
       
        NSLog(@"第二个订阅者接收到的数据%@",x);
    
    }];
    
}


- (void)RACSubjectDemo{

    // RACSubject 使用步骤
//    1 创建信号 [RACSubject subject]  跟RACSignal不一样 创建信号时没有block
//    2 订阅信号 subscribeNext
//    3 发送信号 sendNext
    
    
//    RACSubject底层实现 和RACSignal不一样
//    1 调用SubjectNext 订阅信号  只是把订阅者保存起来  并且订阅者的nextBlock已经赋值了
//    2 调用sendNext 发送信号遍历刚刚保存的订阅者  一个一个调用订阅者的nextBlock
    
    
    
//    1 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2 订阅信号
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者 %@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者  %@",x);
    }];
    
    // 3 发送信号
    [subject sendNext:@123];

}



- (void)RACSignalDemo1{
    
    // 1 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
      
        // 2 发送信号
        [subscriber sendNext:@"123"];
        // 如果不发送数据 最好发送信号完成  内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            //block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁了");
        }];
    }];
    
    // 3 订阅信号
    [signal subscribeNext:^(id x) {
        
//        block 调用时刻 每当有信号发出数据 就会调用block；
        NSLog(@"接收到数据%@",x);
    }];



}


@end
