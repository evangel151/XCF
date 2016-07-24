//
//  LJKSettingFooter.h
//  LJKitchen
//
//  Created by  a on 16/6/10.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKSettingFooter : UIView
/** 设置's Footer - 版本号 */
@property (nonatomic, strong) UILabel *version;
/** 设置's Footer - 退出 */
@property (nonatomic, strong) UIButton *exit;


+ (instancetype)settingFooter;

@end
