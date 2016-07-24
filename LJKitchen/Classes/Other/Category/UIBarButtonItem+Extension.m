//
//  UIBarButtonItem+Extension.m
//  LJKitchen
//
//  Created by  a on 16/7/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (Extension)



+ (instancetype)barButtonItemWithTitle:(NSString *)title
                         selectedTitle:(NSString *)selTitle
                                target:(id)target
                                action:(SEL)action {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitleColor:Color_ThemeColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selTitle forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    return barButtonItem;
}

+ (NSArray <UIBarButtonItem *> *)createShareButtonsWith:(UIViewController *)controller
                                                target:(id)target
                                     firstButtonAction:(SEL)action1
                                    secondButtonAction:(SEL)action2
                                     thirdButtonAction:(SEL)action3
                                    fourthButtonAction:(SEL)action4 {
    

    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@""
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action1];
    back.image = [UIImage imageNamed:@"backStretchBackgroundNormal"];
    
    
    UIBarButtonItem *sharePYQ = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:target
                                                                action:action2];
    sharePYQ.image = [UIImage imageNamed:@"convenient_share_pyq"];
    sharePYQ.tintColor = Color_DarkGray;
    UIBarButtonItem *shareWX = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                style:UIBarButtonItemStylePlain
                                                               target:target
                                                               action:action3];
    shareWX.image = [UIImage imageNamed:@"convenient_share_wx"];
    shareWX.tintColor = Color_DarkGray;
    UIBarButtonItem *shareOther = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:target
                                                                  action:action3];
    shareOther.image = [UIImage imageNamed:@"share_other"];
    shareOther.tintColor = Color_DarkGray;
    
    controller.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:back, sharePYQ, shareWX, shareOther,nil];
    
    return controller.navigationItem.leftBarButtonItems;
}


//- (void)setNavigationBarDidClickedBlock:(void (^)(NSInteger))navigationBarDidClickedBlock {
//    self.navigationBarDidClickedBlock = navigationBarDidClickedBlock;
//}
//
//
//- (void (^)(NSInteger))navigationBarDidClickedBlock {
//    
//}

//- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(LJKBarButtonHandler)completion{
//    
//    [self addTarget:self action:@selector(didClickButton)
//   forControlEvents:controlEvents];
//    
//    void (^block)(void) = ^{
//        completion();
//    };
//    objc_setAssociatedObject(self, BuClickKey, block, OBJC_ASSOCIATION_COPY);
//    
//}


//- (void)addActionforControlEvents:(UIControlEvents)controlEvents respond:(LJKBarButtonHandler)completion {
//    []
//}
//
//-(void)didClickButton{
//    void (^block)(void) = objc_getAssociatedObject(self, BuClickKey);
//    block();
//}


//- (void)backButtonDidClicked {
//    !self.navigationBarDidClickedBlock ? : self.navigationBarDidClickedBlock(LJKNavigationBarButtonTypeBack);
//}
//
//- (void)PYQButtonDidClicked {
//    !self.navigationBarDidClickedBlock ? : self.navigationBarDidClickedBlock(LJKNavigationBarButtonTypeFriendsCircle);
//}
//
//- (void)WeChatButtonDidClicked {
//    !self.navigationBarDidClickedBlock ? : self.navigationBarDidClickedBlock(LJKNavigationBarButtonTypeWeChat);
//}
//
//- (void)OtherButtonDidClicked {
//    !self.navigationBarDidClickedBlock ? : self.navigationBarDidClickedBlock(LJKNavigationBarButtonTypeOthersShareMode);
//}


@end
