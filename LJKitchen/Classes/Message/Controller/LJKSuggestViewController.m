//
//  LJKSuggestViewController.m
//  LJKitchen
//
//  Created by  a on 16/6/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKSuggestViewController.h"
#import "LJKHelpCenterViewController.h"
#import "LJKBasicTextView.h"

@interface LJKSuggestViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate>

/** 意见反馈 - 输入框 */
@property (nonatomic, strong) LJKBasicTextView *textView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *helpButton;
@end

@implementation LJKSuggestViewController
#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrollView.backgroundColor = Color_BackGround;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = YES;
    }
    return _scrollView;
}


- (LJKBasicTextView *)textView {
    if (!_textView) {
        _textView = [[LJKBasicTextView alloc] init];
        _textView.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, SCREEN_HEIGHT * 0.3);
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.placeholder = @"我们有什么可以帮助您的吗？";
        _textView.alwaysBounceVertical = YES;
        _textView.delegate = self;
        // [_textView becomeFirstResponder];
        // 添加通知
        [NotificationCenter addObserver:self
                               selector:@selector(textDidChange)
                                   name:UITextViewTextDidChangeNotification
                                 object:_textView];
    }
    return _textView;
}

- (UIButton *)helpButton {
    if (!_helpButton) {
        _helpButton = [UIButton buttonWithTitle:@"查看帮助中心"
                                     titleColor:Color_ThemeColor
                                backgroundColor:[UIColor clearColor]
                                       fontSize:21
                                         target:self
                                         action:@selector(helpButtonDidClick)];
        _helpButton.frame = CGRectMake(0, SCREEN_HEIGHT * 0.3 + 20 , SCREEN_WIDTH, 50);
    }
    return _helpButton;
}


#pragma mark - 页面主体 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.helpButton];
    [self.scrollView addSubview:self.textView];
    self.title = @"意见建议";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(postSuggestion)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

#pragma mark - 点击事件
// 发送建议to官方
- (void)postSuggestion {
    if (self.textView.text) {
        NSLog(@"%@", self.textView.text);
    }
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showSuccessWithStatus:@"LJKitchen已经收到您的反馈,感谢您的热心支持"];
    [self.navigationController popViewControllerAnimated:YES];
}

// 跳转至帮助中心
- (void)helpButtonDidClick {
    LJKHelpCenterViewController *helpCenter = [[LJKHelpCenterViewController alloc] init];
    [self.navigationController pushViewController:helpCenter animated:YES];
     NSLog(@"跳转至帮助界面——————");
}


#pragma mark - scrollView 代理
// 开始滚动时 退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView endEditing:YES];
}

#pragma mark - 通知相关
/** textView中文字发生改变时做的操作 */
- (void)textDidChange {
    if (self.textView.hasText) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.tintColor = Color_ThemeColor;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
