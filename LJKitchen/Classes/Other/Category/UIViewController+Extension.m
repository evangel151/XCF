//
//  UIViewController+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (void)pushWebViewWithUrl:(NSString *)url {
    
    UIViewController *vc    = [[UIViewController alloc] init];
    UIWebView *webView      = [[UIWebView alloc] initWithFrame:vc.view.bounds];
    webView.backgroundColor = Color_BackGround;
    [vc.view addSubview:webView];
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
    [self.navigationController pushViewController:vc
                                         animated:YES];
    
}

@end
