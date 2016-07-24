//
//  NSString+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/** 类方法:根据给定文字 + 宽度 + 字号 返回size  */
+ (CGSize)getSizeWithString:(NSString*)string
                      width:(CGFloat)width
                       font:(CGFloat)font;

/** 类方法:根据给定文字 + 高度 + 字号 返回size  */
+ (CGSize)getSizeWithString:(NSString*)string
                     height:(CGFloat)height
                       font:(CGFloat)font;

/** 类方法:根据预设Size -> 返回size  */
- (CGSize)getSizeWithEstimatedSize:(CGSize)estimatedSize
                              font:(CGFloat)font;

/** 工具:转化默认时间格式 */
+ (NSString *)timeToRequiredStyleWithText:(NSString *)text;
@end
