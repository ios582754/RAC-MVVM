//
//  WebViewController.m
//  RACTest
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 com.zaoguankeji.www. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [UIWebView new];
    web.frame = self.view.bounds;
      [self.view addSubview:web];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url ]];
    [web loadRequest:request];
  
    // Do any additional setup after loading the view.
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
