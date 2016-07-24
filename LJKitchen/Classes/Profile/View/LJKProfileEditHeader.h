//
//  LJKProfileEditHeader.h
//  LJKitchen
//
//  Created by  a on 16/6/28.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKProfileEditHeader : UIView

/** 头像点击后回调的block */
@property (nonatomic, copy) void (^uploadIconBlock)();

/** 头像接口(测试用) */
@property (nonatomic, strong) UIImage *displayIcon;


@end
