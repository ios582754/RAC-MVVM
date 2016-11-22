//
//  SubjectViewController.m
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "SubjectViewController.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"
@interface SubjectViewController ()

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self map];
    [self faltMap];
    [self flattenMap2];
    // Do any additional setup after loading the view.
}

-(void)map {
    //創建信號
    RACSubject *subject = [RACSubject subject];
    //綁定信號
    RACSignal *signal = [subject map:^id(id value) {
        //返回的類型就是你需要映射的值
        return  [NSString stringWithFormat:@"ws:%@", value]; //这里将源信号发送的“123” 前面拼接了ws：
    }];
    
    //訂閱信號的綁定;
       [signal subscribeNext:^(id x) {
           
           NSLog(@"%@",x);
       }];
                         
    [subject sendNext:@"66666"];
}


- (void)faltMap {
    //創建信號
    RACSubject *subject = [RACSubject subject];
    //綁定信號
    RACSignal *signal = [subject flattenMap:^RACStream *(id value) {
        
        // block：只要源信号发送内容就会调用
        // value: 就是源信号发送的内容
        // 返回信号用来包装成修改内容的值
        return [RACReturnSignal return:[NSString stringWithFormat:@"ws:%@", value]];
 
    }];
    
    // flattenMap中返回的是什么信号，订阅的就是什么信号(那么，x的值等于value的值，如果我们操纵value的值那么x也会随之而变)
    // 订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 发送数据
     [subject sendNext:@"123"];
   
    
}


- (void)flattenMap2 {
    // flattenMap 主要用于信号中的信号
    // 创建信号
    RACSubject *signalofSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 订阅信号
    //方式1
    //    [signalofSignals subscribeNext:^(id x) {
    //
    //        [x subscribeNext:^(id x) {
    //            NSLog(@"%@", x);
    //        }];
    //    }];
    // 方式2
    //    [signalofSignals.switchToLatest  ];
    // 方式3
    //   RACSignal *bignSignal = [signalofSignals flattenMap:^RACStream *(id value) {
    //
    //        //value:就是源信号发送内容
    //        return value;
    //    }];
    //    [bignSignal subscribeNext:^(id x) {
    //        NSLog(@"%@", x);
    //    }];
    // 方式4--------也是开发中常用的
    [[signalofSignals flattenMap:^RACStream *(id value) {
        return value;
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 发送信号
    [signalofSignals sendNext:signal];
    [signal sendNext:@"123"];
}









@end
