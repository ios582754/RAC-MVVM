//
//  RequestViewModel.m
//  ReactiveCocoa
//
//  Created by Mr.Wang on 16/4/20.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "RequestViewModel.h"
#import "NSObject+MJExtension.h"
#import "WebViewController.h"
@implementation Books



@end

@implementation RequestViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
        [self clickToNext];
    }
    return self;
}

- (void)setup {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 执行命令
        // 发送请求
        // 创建信号 把发送请求的代码包装到信号里面。
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"我的天"} progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [responseObject writeToFile:@"/Users/wang/Desktop/plist/sg.plist" atomically:YES];
                // 请求成功的时候调用
               // NSLog(@"%@", responseObject);
                // 在这里就可以拿到数据，将其丢出去
                NSMutableArray *arr = [NSMutableArray array];
                
                NSArray *dictArr = responseObject[@"books"];
                for (NSDictionary *dic in dictArr) {
                     Books *model = [Books parse:dic];
                    [arr addObject:model];
                }
               
                // 便利books字典数组，将其映射为模型数组
                NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                    return [[Books alloc] init];
                }] array];
                
                [subscriber sendNext:arr];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            return nil;
        }];
        
        return signal;  // 模型数组
    }];
    
}

- (void)clickToNext {
    _clickCommand  = [[RACCommand alloc ] initWithSignalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 发送数据
            [subscriber sendNext: [NSString stringWithFormat:@"%@",@"ooooo"]];
            [self weiboDetailWithPublicModel:input [@"model"] WithViewController:input[@"VC"]];
            [subscriber sendCompleted]; // 一定要记得写
        return nil;
    }];
    }];
}

#pragma 跳转到详情页面，如需网路请求的，可在此方法中添加相应的网络请求
-(void) weiboDetailWithPublicModel: (Books *) publicModel WithViewController:(UIViewController *)superController
{
    //DDLog(@"%@,%@,%@",publicModel.userId,publicModel.weiboId,publicModel.text);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    WebViewController *detailController = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    detailController.url = publicModel.url;
    [superController.navigationController pushViewController:detailController animated:YES];
    
}


@end
