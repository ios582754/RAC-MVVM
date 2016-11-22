//
//  CommandViewController.m
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "CommandViewController.h"
#import "ReactiveCocoa.h"
// RACCommand:RAC中用于处理事件的类，可以把事件如何处理，事件中的数据如何传递，包装到这个类中，他可以很方便的监控事件的执行过程，比如看事件有没有执行完毕
// 使用场景：监听按钮点击，网络请求
@interface CommandViewController ()

@end

@implementation CommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testFive];
    // Do any additional setup after loading the view.
}



- (void)testOne {
    // RACCommand: 处理事件
    // 不能返回空的信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //block调用，执行命令的时候就会调用
        NSLog(@"%@",input); // input 为执行命令传进来的参数
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"666"];
        return nil;
        
    }];
        
    }];
    RACSignal *signal = [command execute:@"444 "];
    [signal subscribeNext:^(id x) {
        NSLog(@"x === %@",x);
        
    }];
    
}


//一般做法

- (void)testTwo {
    
    // RACCommand: 处理事件
    // 不能返回空的信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //block调用，执行命令的时候就会调用
        NSLog(@"%@",input); // input 为执行命令传进来的参数
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"666"];
            return nil;
            
        }];
        
    }];
    // 订阅信号
    // 注意：这里必须是先订阅才能发送命令
    // executionSignals：信号源，信号中信号，signalofsignals:信号，发送数据就是信号
    [command.executionSignals subscribeNext:^(RACSignal *x) {
        [x subscribeNext:^(id x) {
           NSLog(@"%@", x);
        }];
       // NSLog(@"%@", x);
    }];
    // 2.执行命令
    [command execute:@2];
    
    
}
//高級做法
- (void)testThree {
    
    // RACCommand: 处理事件
    // 不能返回空的信号
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        //block调用，执行命令的时候就会调用
        NSLog(@"%@",input); // input 为执行命令传进来的参数
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"666"];
            return nil;
            
        }];
        
    }];
    
    // 方式三
    // switchToLatest获取最新发送的信号，只能用于信号中信号。
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 2.执行命令
    [command execute:@3];

}

// switchToLatest
- (void)test4 {
    // 创建信号中信号
    RACSubject *signalofsignals = [RACSubject subject];
    RACSubject *signalA = [RACSubject subject];
    // 订阅信号
        [signalofsignals subscribeNext:^(RACSignal *x) {
            [x subscribeNext:^(id x) {
                NSLog(@"%@", x);
            }];
        }];
    // switchToLatest: 获取信号中信号发送的最新信号
    [signalofsignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 发送信号
    [signalofsignals sendNext:signalA];
    [signalA sendNext:@4];
}
// 监听事件有没有完成
- (void)testFive {
    //注意：当前命令内部发送数据完成，一定要主动发送完成
    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令的时候就会调用
//        NSLog(@"%@", input);
        // 这里的返回值不允许为nil
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送数据
            [subscriber sendNext:@"0"];
            
            // *** 发送完成 **
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    // 监听事件有没有完成
    [command.executing subscribeNext:^(id x) {
        if ([x boolValue] == YES) { // 正在执行
            NSLog(@"当前正在执行%@", x);
        }else {
            
            // 执行完成/没有执行
            NSLog(@"执行完成/没有执行%@",x);
        }
    }];
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    // 2.执行命令
    [command execute:@0];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
