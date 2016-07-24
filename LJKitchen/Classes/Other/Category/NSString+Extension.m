//
//  NSString+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (CGSize)getSizeWithString:(NSString*)string
                      width:(CGFloat)width
                       font:(CGFloat)font {
    CGSize size = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                    context:nil].size;
    return size;
}

+ (CGSize)getSizeWithString:(NSString*)string
                     height:(CGFloat)height
                       font:(CGFloat)font {
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                       context:nil].size;
    return size;
}


- (CGSize)getSizeWithEstimatedSize:(CGSize)estimatedSize
                              font:(CGFloat)font {
    CGSize size = [self boundingRectWithSize:estimatedSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]}
                                           context:nil].size;
    return size;
}


+ (NSString *)timeToRequiredStyleWithText:(NSString *)text {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *latestDate = [formatter dateFromString:text];
    NSDateComponents *components = [latestDate intervalToNow];
    
    if (latestDate.isThisYear) {
        if (latestDate.isYesterday) { // 昨天
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:latestDate];
        } else if (latestDate.isToday) {// 今天
            
            if (components.hour >= 1) { // 当天内 至少1小时前创建
                return [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
            } else if (components.minute > 1) { // 当天内 距离现在 1小时之内创建
                return [NSString stringWithFormat:@"%ld分钟前",(long)components.minute];
            } else { // 1分钟之内新发
                return @"刚刚";
            }
        } else { // 前天 乃至 今年内的所有日子
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:latestDate];
        }
    } else { // 非今年
        // 设置时间格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:latestDate];
    }
}

@end
