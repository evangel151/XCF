//
//  LJKImage.h
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKImage : NSObject
/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;
@end
