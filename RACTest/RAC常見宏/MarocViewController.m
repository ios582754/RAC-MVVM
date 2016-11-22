//
//  MarocViewController.m
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "MarocViewController.h"
#import "ReactiveCocoa.h"
@interface MarocViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) RACSignal *signal;
@end

@implementation MarocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test4];
    // Do any additional setup after loading the view.
}
/**
 *  RAc測試
 */

- (void)test
{
    // RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    // 给label的text属性绑定了文本框改变的信号
    RAC(self.label, text) = self.textField.rac_textSignal;
//        [self.textField.rac_textSignal subscribeNext:^(id x) {
//            self.label.text = x;
//        }];
    
}
/**
 *  KVO
 *  RACObserveL:快速的监听某个对象的某个属性改变
 *  返回的是一个信号,对象的某个属性改变的信号
 */
- (void)test2 {
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}
- (void)testAndtest2 // textField输入的值赋值给label，监听label文字改变,
{
    
    RAC(self.label, text) = self.textField.rac_textSignal;
    [RACObserve(self.label, text) subscribeNext:^(id x) {
        NSLog(@"====label的文字变了");
    }];
    
}

/**
 *  循环引用问题
 */
- (void)test3 {
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSLog(@"%@",self.view);
        return nil;
    }];
    _signal = signal;
}
/**
 * 元祖
 * 快速包装一个元组
 * 把包装的类型放在宏的参数里面,就会自动包装
 */
- (void)test4 {
    RACTuple *tuple = RACTuplePack(@1,@2,@"4");
    // 宏的参数类型要和元祖中元素类型一致， 右边为要解析的元祖。
    RACTupleUnpack_(NSNumber *num1, NSNumber *num2, NSString * num3) = tuple;// 4.元祖
    // 快速包装一个元组
    // 把包装的类型放在宏的参数里面,就会自动包装
    NSLog(@"%@ %@ %@", num1, num2, num3);
    
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
