//
//  LJKNavigationController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKNavigationController.h"

@interface LJKNavigationController ()

@end

@implementation LJKNavigationController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 设置默认的导航栏标题属性
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,
                                        [UIFont systemFontOfSize:21],NSFontAttributeName,nil]];
}



// 重写pushViewController方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) { // 此时Push进来的控制器不是第一个控制器 (非根控制器)
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; // 左对齐
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = backItem;
        
        // 边距修正 (没必要...)
//        UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        fixedItem.width = -5;

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
