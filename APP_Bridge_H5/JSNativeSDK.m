//
//  JSNativeSDK.m
//  JSNativeSDK
//
//  Created by Wyzc on 15/11/4.
//  Copyright © 2015年 Wyzc. All rights reserved.
//

#import "JSNativeSDK.h"

@implementation JSNativeSDK
@synthesize webView;

- (id)initWithWebView:(UIWebView *)uiWebView bridgeKey:(NSString *)bridgeKey{
    if (self = [super init])
    {
        self.webView = uiWebView;
        self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.context[bridgeKey] = self;
    }
    return self;
}

- (NSString *)h5CallApp:(NSString *)type{
    NSLog(@"H5 Call APP    %@", type);
    
    return @"H5调用APP同步返回的参数";
}

/**
 *  对象转JSON串
 *
 *  @param object 数据
 *
 *  @return jsonString
 */
-(NSString*)DataToJsonString:(id)object
{
    NSError     *error;
    NSString    *jsonString = nil;
    NSData      *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                            options:NSJSONWritingPrettyPrinted
                                                              error:&error];
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
       NSLog(@"Got an error: %@", error);
    }
    return jsonString;
}
@end
