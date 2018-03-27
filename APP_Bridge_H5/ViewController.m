//
//  ViewController.m
//  APP_Bridge_H5
//
//  Created by EGRUN on 2018/3/27.
//  Copyright © 2018年 EGRUN. All rights reserved.
//

#import "ViewController.h"
#import "JSNativeSDK.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>

@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSNativeSDK *nativeSDK;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test.html" ofType:nil];
    NSString *htmlStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [NSURL URLWithString:path];
    [self.webView loadHTMLString:htmlStr baseURL:url];
    
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
    test.backgroundColor = [UIColor redColor];
    [test setTitle:@"点击APP调用H5方法" forState:UIControlStateNormal];
    [test setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [test addTarget:self action:@selector(testAppToH5:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:test];
}

// APP
- (void)testAppToH5:(UIButton *)sender{
    //通过OC调用此方法
    NSString * method = @"returnLogin";
    JSValue * function = [self.nativeSDK.context objectForKeyedSubscript:method];
    //这里面的a,b,c就是OC调用JS的时候给JS传的参数
    [function callWithArguments:@[@"APP直接调用H5方法，传参"]];
}

- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        [_webView setScalesPageToFit:YES];
    }
    return _webView;
}

#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    self.nativeSDK = [[JSNativeSDK alloc] initWithWebView:webView bridgeKey:@"native"];
    
    // 根据H5页面的标题设置APP本地标题
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
