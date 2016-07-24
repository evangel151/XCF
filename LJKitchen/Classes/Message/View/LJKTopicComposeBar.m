//
//  LJKTopicComposeBar.m
//  LJKitchen
//
//  Created by  a on 16/6/26.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTopicComposeBar.h"

#import <Masonry.h>

@interface LJKTopicComposeBar () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *postButton;

@end


@implementation LJKTopicComposeBar

#pragma mark - 懒加载
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = Color_BackGround;
        _textView.delegate = self;
        _textView.layer.cornerRadius = 5;
    }
    return _textView;
}

- (UIButton *)postButton {
    if (!_postButton) {
        _postButton = [UIButton buttonWithBackgroundColor:Color_ThemeColor_Alpha
                                                    title:@"发送"
                                                 fontSize:13
                                               titleColor:Color_TintWhite
                                                   target:self
                                                   action:@selector(postDidClick)
                                            clipsToBounds:YES];
    }
    return _postButton;
}

#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame = CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44);
        self.backgroundColor = Color_ThemeColor_Yellow;  // 鹅黄色 
        
        [NotificationCenter addObserver:self
                               selector:@selector(textViewTextDidChange:)                                                     name:UITextViewTextDidChangeNotification
                                 object:self.textView];
        
        [self addSubview:self.textView];
        [self addSubview:self.postButton];
        
        [_postButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(7);
            make.bottom.equalTo(self.mas_bottom).offset(-7);
            make.right.equalTo(self.mas_right).offset(-LJKAuthorIcon2CellLeft);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.postButton.mas_height);
            make.left.equalTo(self.mas_left).offset(LJKAuthorIcon2CellLeft);
            make.top.equalTo(self.postButton.mas_top);
            make.right.equalTo(self.postButton.mas_left).offset(-10);
        }];
    }
    return self;
}

// 快速创建
+ (instancetype)addCompostBarWithEditingTextBlock:(EditingTextBlock)editingTextBlock {
    LJKTopicComposeBar *composeBar = [[LJKTopicComposeBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 44, SCREEN_WIDTH, 44)];
    composeBar.editingTextBlock = editingTextBlock;
    return composeBar;
}

#pragma mark - 事件处理
// 回传textView上的文字
- (void)textViewTextDidChange:(NSNotification *)note {
    !self.editingTextBlock ? : self.editingTextBlock(self.textView.text);
}

- (void)postDidClick {
     NSLog(@"发送评论到服务器——————");
    self.textView.text = @""; // 发送后清空
}

#pragma mark - 销毁通知
- (void)dealloc {
    [NotificationCenter removeObserver:self];
}

@end
