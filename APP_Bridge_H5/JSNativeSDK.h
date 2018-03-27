//
//  JSNativeSDK.h
//  JSNativeSDK
//
//  Created by HQS on 15/11/4.
//  Copyright © 2015年 HQS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol JSNativeExport <JSExport>
JSExportAs(bridge, -(NSString *)bridge : (NSString *)type data:(NSString *)jsonData);// 多参数
JSExportAs(h5CallApp, -(NSString *)h5CallApp : (NSString *)type);   // 单参数
@end

@interface JSNativeSDK : NSObject <JSNativeExport>
- (id)initWithWebView:(UIWebView *)uiWebView bridgeKey:(NSString *)bridgeKey;

@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@end
