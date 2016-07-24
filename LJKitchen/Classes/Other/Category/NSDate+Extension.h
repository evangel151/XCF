//
//  NSDate+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** 快速比较当前时间和传入时间的时间差 */
- (NSDateComponents *)intervalToNow;
/** 是否为今年 -> 可判断 今年/其他年 */
- (BOOL)isThisYear;
/** 是否为今天 */
- (BOOL)isToday;
/** 是否为昨天 */
- (BOOL)isYesterday;
@end
