//
//  NSDate+Extension.m
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)intervalToDate:(NSDate *)date {

    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit
                       fromDate:self
                         toDate:date
                        options:0];
}

- (NSDateComponents *)intervalToNow {
    
    return [self intervalToDate:[NSDate date]];
}

/** 是否为今年 -> 可判断 今年/其他年 */
- (BOOL)isThisYear {
    NSCalendar *calendar =  [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger now = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];

    return now == selfYear;
}
/** 是否为今天 */
- (BOOL)isToday {
    NSCalendar *calendar =  [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *today = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfDay = [calendar components:unit fromDate:self];
    
    return today.day == selfDay.day && today.month == selfDay.month && today.year == selfDay.year;
}
/** 是否为昨天 */
- (BOOL)isYesterday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [formatter stringFromDate:[NSDate date]];
    NSDate *nowDate = [formatter dateFromString:nowString];
    NSString *selfString = [formatter stringFromDate:self];
    NSDate *selfDate = [formatter dateFromString:selfString];
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    // 比较两者之间的差值  符合 3个条件的才是昨天
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}




@end
