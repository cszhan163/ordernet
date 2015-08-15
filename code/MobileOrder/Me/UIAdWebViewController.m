//
//  UIAdWebViewController.m
//  MobileOrder
//
//  Created by kuben on 15/8/15.
//  Copyright (c) 2015年 com.ximalaya. All rights reserved.
//

#import "UIAdWebViewController.h"

@interface UIAdWebViewController () {

    UIWebView  *_webView;
}

@end

@implementation UIAdWebViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0.f, offsetY, kDeviceScreenWidth, kDeviceScreenHeight-offsetY)];
    [self.view addSubview:_webView];
    SafeRelease(_webView);
    NSString *urlStr = [self.adDataItem objectForKey:@"clickUrl"];
    NSURLRequest  *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];

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
