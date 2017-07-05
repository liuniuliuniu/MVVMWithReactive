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
    
    
//    [self flattenMapDemo];
    
//    [self mapDemo];
    
//    [self signalOfSignals];
    
//    [self concatDemo];
    
//    [self thenDemo];
    
//    [self mergeDemo];
    
//    [self zipDemo];
    
//    [self combineLatestDemo];
    
//    [self reduceDemo];
    
//    [self filterDemo];
    
//    [self ignoreDemo];
    
//    [self distinctUntilChangedDemo];
    
//    [self takeDemo];
    
//    [self takeLastDemo];
    
//    [self tabkeUntilDemo];
    
//    [self skipDemo];
    
//    [self doNextAnddoCompleteDemo];
    
//    [self deliverOnDemo];
    
//    [self timeoutDemo];
    
//    [self intervalDemo];
    
//    [self delayDemo];
    
//    [self retryDemo];
    
//    [self replayDemo];
    
//    [self throttleDemo];
    
    
    
    
    
    
}

- (void)throttleDemo{
    
    
    
    
    



}



// 没什么卵用  在我看来
- (void)replayDemo{
    
    
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"123"];
        
        [subscriber sendNext:@"456"];
        
        
        
        return nil;
    }]replay];
    
    
    
    [signal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];

    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    








}





- (void)retryDemo{

    __block int i = 0;
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        if (i == 10) {
            [subscriber sendNext:@"123"];
            
            
        }else{
            
            [subscriber sendError:nil];
        
        }
        
        i++;
        
        return nil;
        
    }] retry ] subscribeNext:^(id x) {
       
        NSLog(@"subscribeNext--%@",x);
        
    }error:^(NSError *error) {
      
        NSLog(@"error--%@",error);
        
    }];
    

}




- (void)delayDemo{
    
    
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"延迟两秒钟"];
        
        return nil;
        
    }] delay:2] subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
        
    }];
    
    
    
    
    
    




}



- (void)intervalDemo{
    
    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];


}



- (void)timeoutDemo{

    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        [subscriber sendNext:@"123"];
        
        return nil;
        
        
    }] timeout:3 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
       
        
        NSLog(@"subscribeNext-%@",x);
        
        
    } error:^(NSError *error) {
        
        NSLog(@"error-%@",error);
        
    }];

    




}


- (void)deliverOnDemo{

    
    




}


- (void)doNextAnddoCompleteDemo{

    
    
    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [subscriber sendNext:@"我是奥卡姆剃须刀"];
        
        [subscriber sendCompleted];
        
        
        return nil;
        // 在执行订阅信号之前 会先执行这个方法
    }]doNext:^(id x) {
      
        NSLog(@"doNext--%@",x);
        
        // 信号完成后会调用这个方法
    }]doCompleted:^{
      
        NSLog(@"完成");
        
        // 订阅信号
    }] subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
        
    }];









}






- (void)skipDemo{
    
    
    

    RACSubject *signal = [RACSubject subject];
    
    
    [[signal skip:1] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    
    [signal sendNext:@"我是信号一"];
    
    [signal sendNext:@"我是信号二"];
    
    
    
    
    
    
    
}





- (void)tabkeUntilDemo{

    // 创建一个信号
    RACSignal *deallocSignal = [self rac_signalForSelector:@selector(viewWillDisappear:)];
    
    // 当deallocSignal信号发送的时候 就会移除通知
    [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:deallocSignal] subscribeNext:^(id x) {
        NSLog(@"键盘弹出%@",x);
    }];
    
    
    


}




- (void)takeLastDemo{

    
    RACSubject *signal = [RACSubject subject];

    // 去最后n次的信号
    
    [[signal takeLast:2] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    [signal sendNext:@"1"];
    
    
    [signal sendNext:@"2"];
    
    [signal sendNext:@"3"];
    
    [signal sendNext:@"4"];
    
    
    // 必须调用完成  只用调用完成才能知道总共的信号量
    [signal sendCompleted];
    


}




- (void)takeDemo{
    
    
    // 1 创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 2 处理信号 订阅信号的个数  如果订阅一个 只会接受第一个信号  subject 可以先订阅信号  在发送信号
    [[signal take:2] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    
    [signal sendNext:@"1"];
    
    [signal sendNext:@"2"];
    
    
    
    
    



}



- (void)distinctUntilChangedDemo{

    
    [[_textFiled.rac_textSignal distinctUntilChanged] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];

}





- (void)ignoreDemo{

    
    // 只能忽略相等的值  其他的都忽略不了 内部调用的是filter过滤
    [[self.textFiled.rac_textSignal ignore:@"123"] subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];





}

- (void)filterDemo{

    
   RACSignal *newSignal =  [self.textFiled.rac_textSignal filter:^BOOL(NSString * value) {
       
        return value.length > 3;
        
    }];
    
    [newSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    

}




- (void)reduceDemo{
    
    
    
    RACSignal *oneSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"我是第一个信号"];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    RACSignal *twoSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"我是第二个的信号"];
        
        [subscriber sendCompleted];
        
        return nil;
    
    }];
    
    // 聚合
    // 常见的用法 (先组合在聚合)
    
    // combineLatee里边有多少个参数组合  后边的reduce就应该有多少个参数
    
    //  reduce 返回值是聚合之后的内容
    
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[oneSignal,twoSignal] reduce:^id(NSString *data1,NSString *data2){
        
        return [NSString stringWithFormat:@"我是数据一%@---我是数据二%@",data1,data2];
        
    }];
    
    [reduceSignal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
        
    }];
    
    
    

    
    
    
    




}



- (void)combineLatestDemo{
    
    
    RACSignal *oneSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [subscriber sendNext:@"我是第一个信号"];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    RACSignal *twoSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"我是第二个的信号"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];

    
    //  必须两个都发信号 才会触发合并信号  和zipWith 一样没什么区别  也是会组装成元祖
    RACSignal *combineSignal = [oneSignal combineLatestWith:twoSignal];
    
    [combineSignal subscribeNext:^(id x) {
       
        RACTupleUnpack(id data1,id data2) = x;
        
        NSLog(@"%@--%@",data1,data2);
        
    }];
    


}





- (void)zipDemo{

    
    RACSignal *oneSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [subscriber sendNext:@"我是第一个信号"];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    RACSignal *twoSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"我是第二个的信号"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];

    
    RACSignal *zipSignal = [oneSignal zipWith:twoSignal];
    
    [zipSignal subscribeNext:^(id x) {
       
        
        
        RACTupleUnpack(id data1,id  data2) = x;
        
        NSLog(@"%@---%@",data1,data2);
        
    }];
    




}





- (void)mergeDemo{

    // 底层实现：
    // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
    // 2.每发出一个信号，这个信号就会被订阅
    // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
    // 4.只要有一个信号被发出就会被监听。
    
    
    RACSignal *oneSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [subscriber sendNext:@"我是第一个信号"];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    RACSignal *twoSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"我是第二个的信号"];
            
            [subscriber sendCompleted];
            
            return nil;
    }];

    
    RACSignal *mergeSignal = [oneSignal merge:twoSignal];
    
    [mergeSignal subscribeNext:^(id x) {
       
        NSLog(@"%@",x);
        
    }];
    
    
    
    
    
    
    
    

    
    










}


- (void)thenDemo{
    

    
    RACSignal *oneSignal =  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [subscriber sendNext:@"我是信号"];
        
        //  只有当第一个信号完成后 第二个信号才会执行
        [subscriber sendCompleted];
        
        return nil;
        
    }];
    
    RACSignal *twoSignal = [oneSignal   then:^RACSignal *{
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@"我是第二个的信号"];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    // 订阅第一个信号
    [oneSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 订阅第二个信号  只有第一个信号完成后 第二个信号发挥被触发
    [twoSignal  subscribeNext:^(id x) {
        
        
        NSLog(@"%@",x);
    }];









}




- (void)concatDemo{
    
    
//    按一定顺序拼接信号 当多个信号发出的时候有顺序的接受信号
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
            [subscriber sendNext:@"我是一号"];
            
            [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        [subscriber sendNext:@"我是二号"];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    
    RACSignal *concatSignal = [signal2 concat:signal1];
    
    //  只有第一个信号完成后 才会执行第二个信号
    [concatSignal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];
    
    
    
    







}



- (void)signalOfSignals{
    
    
    RACSubject *signalOfsignals = [RACSubject  subject];
    
    RACSubject *signal = [RACSubject subject];
    
    [[signalOfsignals flattenMap:^RACStream *(id value) {
     
        // 当signalOfsignal 的signal发发出信号才会调用
        
        NSLog(@"拦截%@",value);
        
        return value;
        
    }] subscribeNext:^(id x) {
        
        NSLog(@"内容%@",x);
        
    }];
    
    // 信号的信号发送信号
    [signalOfsignals sendNext:signal];
    
    [signal sendNext:@"奥卡姆剃须刀"];
    
    
}



- (void)mapDemo{
    
    
//    map 的使用步骤
    // 1 传入一个block 类型是返回对象 参数是value
    // 2 value就是原信号的内容 直接拿到原信号的内容做处理
    // 3 吧处理好的内容直接返回就好了 不用包装成信号   返回的值就是映射的值
    
    [[self.textFiled.rac_textSignal map:^id(id value) {
        
        return [NSString stringWithFormat:@"内容：%@",value];
        
    }]subscribeNext:^(id x) {
      
        NSLog(@"%@",x);
        
    }];
    
}



- (void)flattenMapDemo{
    
    [[self.textFiled.rac_textSignal flattenMap:^RACStream *(id value) {
        
        // 原信号发出的时候就会调用block
        // block作用 ： 改变原信号的内容
        
        //  返回值  绑定信号的内容
        return [RACReturnSignal return:[NSString stringWithFormat:@"内容%@",value]];
        
    }]subscribeNext:^(id x) {
      
        
        NSLog(@"%@",x);
        
    }];
    
}






- (void)bind{
    
    //  处理原有信号  对信号进行加工
    // bind 方法参数  需要传入一个返回值是 RACStreamBindBlock 的参数
    // RACStreamBindBlock 是一个block类型  返回值是信号  参数是value和stop  因此参数block返回值也是一个block
    
    
    
    // RACStreamBindBlock
    // value 表示接收到信号的原始值 还没做处理
    // *stop 用来控制绑定block 如果 *stop = yes 那么就会结束绑定
    // 返回值： 信号 做好处理 在通过这个信号返回出去 一般使用RACreturnsignal，需要手动导入头文件RACReturnSignal.h
    
    
    // bind方法使用步骤：
    // 1 传入一个返回值为 RACStreamBindBlock 的bindblock
    // 2 描述一个RACStreamBindBlock 类型的bindblock作为block的返回值
    // 3 描述一个返回结果的信号 作为bindblock的返回值
    //  在bindblock中做信号结果的处理
    
    // 底层实现:
    // 1 源信号调用bind,会重新创建一个绑定信号。
    // 2 当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。
    // 3 当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
    // 4 调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。
    // 5 订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
    
    
    //  不同的订阅这保存不同的Nextblock 看源码的时候一定要看清楚订阅者是哪一个
    [[self.textFiled.rac_textSignal bind:^RACStreamBindBlock{
        
        return ^RACStream *(id value,BOOL *stop){
            
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出%@",value]];
        };
        
    }] subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
        
    }];


}


- (void)textSignal{


    
        [RACObserve(self.textFiled,center ) subscribeNext:^(id x) {
    
            NSLog(@"%@",x);
    
        }];
    
    
    
        RAC(self.label,text) = self.textFiled.rac_textSignal;
    
    
    
        [self.textFiled.rac_textSignal subscribeNext:^(id x) {
            NSLog(@"内容:%@",x);
        }];
    

}



- (void)noti{


    
    
    // 正确的写法 1  这个写法 当dealloc信号发出的时候 就释放通知
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
    
            NSLog(@"键盘弹出");
    
        }];
    
    
//     正确的写法2
    
    
        RACSignal *deallocSignal = [self rac_signalForSelector:@selector(viewWillDisappear:)];
    
        [[[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:deallocSignal] subscribeNext:^(id x) {
            NSLog(@"键盘弹出%@",x);
        }];
    
    
    
    
//     错误的 写法
        [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
    
            NSLog(@"%@",x);
            
        }];
        
    


}




- (IBAction)delegateBtn:(id)sender {
    
    if (self.delagateSignal) {
        // 发送信号
        [self.delagateSignal sendNext:@"我是从详情里边出来的哈哈"];
    }
    
}

@end
