//
//  LJKHomeHeader.h
//  LJKitchen
//
//  Created by  a on 16/6/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  首页顶部视图主体 (V)

/** 顶部导航视图点击事件 */
typedef NS_ENUM(NSInteger, viewDidClickedAction) {
    // 顶部
    viewDidClickedActionPopularImageView     = 0,// 流行菜谱
    viewDidClickedActionFeedsView            = 1,// 关注动态

    // 中部
    viewDidClickedActionTopListButton        = 2,// 排行榜
    viewDidClickedActionVideoButton          = 3,// 看视频
    viewDidClickedActionBuyButton            = 4,// 买买买
    viewDidClickedActionRecipeCategoryButton = 5,// 菜谱分类

    // 底部
    viewDidClickedActionBreakfast            = 6,// 早餐
    viewDidClickedActionLunch                = 7,// 午餐
    viewDidClickedActionSupper               = 8,// 晚餐
    
    // 中部新增广告条
    viewDidClickedActionFristAuthor          = 10// 新用户优惠
};

/** Block Def */
typedef void (^viewDidClickedBlock)();

#import <UIKit/UIKit.h>
@class LJKNavContent, LJKDish;
@interface LJKHomeHeader : UIView

/** 导航模型数据 */
@property (nonatomic, strong) LJKNavContent *navContent;

/** 动态模型数据 */
@property (nonatomic, strong) LJKDish *dish;

/** Header各部分view点击后回调 */
@property (nonatomic, copy) viewDidClickedBlock clickBlock;
@end
