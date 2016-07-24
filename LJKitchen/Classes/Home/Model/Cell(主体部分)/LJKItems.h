//
//  LJKItems.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJKContents;
@interface LJKItems : NSObject
/** 发布日期 */
@property (nonatomic, copy) NSString *publish_time;
/** 网页URL */
@property (nonatomic, copy) NSString *url;
/** 模板代号 */
@property (nonatomic, assign) NSInteger template;
/** id */
@property (nonatomic, copy) NSString *ID;
/** 模板内容 */
@property (nonatomic, strong) LJKContents *contents;
/** 未知…… */
@property (nonatomic, copy) NSString *column_name;

/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;
@end
