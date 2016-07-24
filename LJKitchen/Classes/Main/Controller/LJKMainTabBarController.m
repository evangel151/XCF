//
//  LJKMainTabBarController.m
//  LJKitchen
//
//  Created by  a on 16/6/8.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKMainTabBarController.h"
#import "LJKNavigationController.h"
#import "LJKHomeViewController.h"       // 首页
#import "LJKMarketViewController.h"     // 市集
#import "LJKMessageViewController.h"    // 信箱
#import "LJKProfileViewController.h"    // "我"

@implementation LJKMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LJKHomeViewController *home       = [[LJKHomeViewController alloc] init];
    LJKMarketViewController *market   = [[LJKMarketViewController alloc] init];
    LJKMessageViewController *message = [[LJKMessageViewController alloc] init];
    LJKProfileViewController *profile = [[LJKProfileViewController alloc] init];
    
    [self addChildViewController:home title:@"下厨房"
                           image:@"tabADeselected"
                   selectedImage:@"tabASelected"];
    
    [self addChildViewController:market
                           title:@"市集"
                           image:@"tabCSelected-1"
                   selectedImage:@"tabBSelected"];
    
    [self addChildViewController:message
                           title:@"信箱"
                           image:@"tabCDeselected"
                   selectedImage:@"tabCSelected"];
    
    [self addChildViewController:profile
                           title:@"我"
                           image:@"tabDDeselected"
                   selectedImage:@"tabDSelected"];
    
}

// 添加TabBar子控制器 
- (void)addChildViewController:(UIViewController *)childVc
                         title:(NSString *)title
                         image:(NSString *)image
                 selectedImage:(NSString *)selectedImage {
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    childVc.title = title;
    
    LJKNavigationController *naviVc = [[LJKNavigationController alloc] initWithRootViewController:childVc];
    [naviVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_ThemeColor}
                                     forState:UIControlStateSelected];
    [self addChildViewController:naviVc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
