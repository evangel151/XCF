//
//  LJKBasicTextView.m
//  LJKitchen
//
//  Created by  a on 16/6/9.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Done

#import "LJKBasicTextView.h"

@interface LJKBasicTextView ()

@end

@implementation LJKBasicTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置通知监听 textView发生的变化
        [NotificationCenter addObserver:self
                               selector:@selector(textDidChange)
                                   name:UITextViewTextDidChangeNotification
                                 object:self];
    }
    return self;
}

#pragma mark - 完善封装性 & Debug
/** 重写placeholder属性的setter */
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy]; 
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}


/**  写入纯文本时 调用drawRect */
- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}

/**  改变字体 调用drawRect */
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

/** 写入带属性的文字时 (表情) 调用drawRect */
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

#pragma mark - 监听文字发生改变 显示/隐藏占位符
/** 监听文字改变 （文字发生改变会进行重绘） */
- (void)textDidChange {
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) { // 如果textView内有文字 就重新调用一次该方法，直接返回(会擦掉原有的绘制的文字)
        return;
    }
    // 设置文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : Color_DarkGray;
    CGFloat phX = 5;
    CGFloat phY = 8;
    CGFloat phW = rect.size.width - 2 * phX;
    CGFloat phH = rect.size.height - 2 * phY;
    CGRect phRect = CGRectMake(phX, phY, phW, phH);
    [self.placeholder drawInRect:phRect withAttributes:attrs];
}

#pragma mark - 移除通知
- (void)dealloc {
    [NotificationCenter removeObserver:self];
}
@end
