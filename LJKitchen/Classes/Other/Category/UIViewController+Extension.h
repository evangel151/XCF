//
//  UIViewController+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
/** 跳转至对应webView */
- (void)pushWebViewWithUrl:(NSString *)url;
@end
