//
//  LJKImage.m
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKImage.h"

@implementation LJKImage

// 图片高度适配
- (CGFloat)height {
    return _height * (SCREEN_WIDTH / self.width);
}
@end
