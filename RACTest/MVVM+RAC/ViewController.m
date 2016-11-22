//
//  ViewController.m
//  RACTest
//
//  Created by apple on 16/11/19.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveCocoa.h"
#import "RACReturnSignal.h"
#import "loginViewModel.h"
#import "RequestViewModel.h"
#import "NSObject+MJExtension.h"
#import "DetileTableViewCell.h"
static NSString *const MYCELL = @"cellID";
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic, strong) loginViewModel *loginVM;
@property(nonatomic, strong)RequestViewModel *requestVM;
/* <#name#>数据数组  */
@property(nonatomic ,strong) NSMutableArray * dataArr;
@property (weak, nonatomic) IBOutlet UITableView *mybookTableView;
@end

@implementation ViewController



#pragma mark -----------dataArr-------------------懒加载;
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}
- (loginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[loginViewModel alloc] init];
    }
    return _loginVM;
}
- (RequestViewModel *)requestVM {
    if (!_requestVM) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.tableView registerClass:[DetileTableViewCell class] forCellReuseIdentifier:MYCELL];
       self.loginVM = [loginViewModel new ];
    // Do any additional setup after loading the view, typically from a nib.
    
    // MVVM:
    // VM:视图模型----处理展示的业务逻辑  最好不要包括视图
    // 每一个控制器都对应一个VM模型
    // MVVM:开发中先创建VM，把业务逻辑处理好，然后在控制器里执行
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    [signal subscribeNext:^(id x) {
        self.dataArr = x;
        [self.tableView reloadData];
    }];
  
    [self bindViewModel];
    [self loginEvent];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];


}
- (void)bindViewModel {
    // 1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM, account) = self.accountField.rac_textSignal;
    RAC(self.loginVM, pwd) = self.pwdField.rac_textSignal;
    
}
- (void)loginEvent {
    // 1.处理文本框业务逻辑--- 设置按钮是否能点击
    RAC(self.loginBtn,enabled) = self.loginVM.loginEnableSignal;
    // 2.监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件
        [self.loginVM.loginCommand execute:nil];
        
    }];
}

#pragma UITableViewDelegeate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count> 0?self.dataArr.count:0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MYCELL];
    Books *model = self.dataArr[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Books *publicViewModel = self.dataArr[indexPath.row];
    NSLog(@"%@",publicViewModel.author[0]);
    Rating *ratingModel = publicViewModel.rating;
    //NSLog(@"%ld",ratingModel.max);
    NSDictionary *dic = @{@"model" :publicViewModel,@"VC":self};
    [self.requestVM.clickCommand execute:dic];
//    RACSignal *clickCommandsignal = [self.requestVM.clickCommand execute:dic];
//    [clickCommandsignal subscribeNext:^(id x) {
//        
//        NSLog(@"%@111",x);
//        //[self.tableView reloadData];
//    }];
//    Books *publicViewModel = self.dataArr[indexPath.row];
//    [RequestViewModel weiboDetailWithPublicModel:publicViewModel WithViewController:self];
}

@end
