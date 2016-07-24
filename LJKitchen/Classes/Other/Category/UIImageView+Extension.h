//
//  UIImageView+Extension.h
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)

/** 扩展: 根据url及给定圆角尺寸返回用户或占位头像 (圆角尺寸以原图尺寸为准)  */
- (void)setCircleIconWithUrl:(NSURL *)url
                 placeHolder:(NSString *)placeHolder
                  cornRadius:(CGFloat)cornRadius;

/** 扩展: 根据url返回对应用户头像或占位头像  */
- (void)setNormalIconWithUrl:(NSURL *)url
                 placeHolder:(NSString *)placeHolder;
@end
