//
//  LJKConst.h
//  LJKitchen
//
//  Created by  a on 16/6/12.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  Const 项目内各项常量 

#import <Foundation/Foundation.h>

/**  首页cell - 模板类型枚举 */
typedef NS_ENUM (NSInteger, LJKCellTemplate){
    LJKCellTemplateTopic = 1,           // 帖子
    LJKCellTemplateRecipeList = 2,      // 菜单
    LJKCellTemplateUnknow = 3,          // 未知
    LJKCellTemplateDish = 4,            // 作品
    LJKCellTemplateRecipe = 5,          // 菜谱
    LJKCellTemplateWeeklyMagazine = 6   // 周刊
};

/** 配图 - 图片展示类型枚举 */
typedef NS_ENUM (NSInteger, LJKShowViewType) {
    LJKShowViewTypeDish,    // 作品
    LJKShowViewTypeReview,  // 评价
    LJKShowViewTypeGoods,   // 商品
    LJKShowViewTypeDetail   // 详细展示
};

/** 垂直方向的Cell - 类型 (collectionViewCell) */
typedef NS_ENUM(NSInteger, LJKVerticalCellType) {
    LJKVerticalCellTypeDish,    // 作品
    LJKVerticalCellTypeReview   // 评价
};


/** 购物车中商品当前状态 */
typedef NS_ENUM(NSUInteger, LJKCartItemState) {
    LJKCartItemStateNone,       // 未选中
    LJKCartItemStateSelected    // 选中
};


/** 购物车view子控件的类型：购物车/订单 */
typedef NS_ENUM(NSUInteger, LJKCartViewChildControlStyle) {
    LJKCartViewChildControlStyleCart,  // 购物车
    LJKCartViewChildControlStyleOrder  // 订单
};

/** 顶部导航按钮组 - 分享 */
typedef NS_ENUM(NSUInteger, LJKNavigationBarButtonType) {
    LJKNavigationBarButtonTypeBack,             // 返回
    LJKNavigationBarButtonTypeFriendsCircle,    // 朋友圈
    LJKNavigationBarButtonTypeWeChat,           // 微信
    LJKNavigationBarButtonTypeOthersShareMode   // 其他分享
};


/** 项目内通用常量 */
/** 下厨房 - 标题距离屏幕左边的间距 */
UIKIT_EXTERN CGFloat const LJKRecipeCellMarginTitle;
/** 下厨房 - 大标题距离屏幕左边的间距 */
UIKIT_EXTERN CGFloat const LJKRecipeCellMarginFirstTitle;
/** 下厨房 - 描述与标题之间的间距 */
UIKIT_EXTERN CGFloat const LJKRecipeCellMarginTitle2Desc;
/** 下厨房 - 底部标题距离底部容器的距离 */
UIKIT_EXTERN CGFloat const LJKRecipeCellMarginTitle2Top;
/** 下厨房 - 菜单 - 标题距离顶部导航的间距 */
UIKIT_EXTERN CGFloat const LJKRecipeListViewMarginHeadTitle;
/** 下厨房 - 菜单 - 标题距离作者名字的间距 */
UIKIT_EXTERN CGFloat const LJKRecipeListViewMarginHeadTitle2Name;

/** 下厨房 - 头像宽高 */
UIKIT_EXTERN CGFloat const LJKAuthorIconWH;
/** 下厨房 - 复合头像宽高(社区用) */
UIKIT_EXTERN CGFloat const LJKAuthorIconsWH;
/** 下厨房 - 头像距离cell顶部的距离 */
UIKIT_EXTERN CGFloat const LJKAuthorIcon2CellTop;
/** 下厨房 - 头像距离cell左边的距离 */
UIKIT_EXTERN CGFloat const LJKAuthorIcon2CellLeft;

/** 下厨房 - 功能型圆形按钮的宽高(正方形) */
UIKIT_EXTERN CGFloat const LJKDiggsButtonWH;


/** 下厨房 - 顶部导航视图高度（流行菜谱、关注动态） */
UIKIT_EXTERN CGFloat const LJKHomeHeader_TopNav_Height;
/** 下厨房 - 导航按钮高度（排行榜、看视频、买买买、菜谱分类） */
UIKIT_EXTERN CGFloat const LJKHomeHeader_CenterNav_Height;
/** 下厨房 - 导航按钮高度（scrollView 滚动条） */
UIKIT_EXTERN CGFloat const LJKHomeHeader_BottomNav_Height;
/** 下厨房 - 新用户优惠 */
UIKIT_EXTERN CGFloat const LJKHomeHeader_NewAuthor_Height;

/** 下厨房 - 菜单 - 作者名字高度 */
UIKIT_EXTERN CGFloat const LJKRecipeListViewHeightAuthorName;
/** 下厨房 - 菜单 - “收藏按钮”高度 */
UIKIT_EXTERN CGFloat const LJKRecipeListViewHeightCollectButton;
/** 下厨房 - 菜单 - 专家图标宽高 */
UIKIT_EXTERN CGFloat const LJKRecipeListViewHeightExpertIcon;



/** 商品界面 - 加入购物车 - 商品分类最小高度 */
UIKIT_EXTERN CGFloat const LJKGoodsKindsCategoryViewMinusHeight;
/** 商品界面 - 购物车 - 圆形确认(选中)按钮宽高 */
UIKIT_EXTERN CGFloat const LJKCircleCheckMarkWH;
/** 商品界面 - 购物车 - 商品配图宽高 */
UIKIT_EXTERN CGFloat const LJKCartItemMainImageWH;

/** 商品界面 - 购物车 - 结算工具条高度 */
UIKIT_EXTERN CGFloat const LJKCartSettlementViewHeight;


/** 下厨房 - 个人界面-顶部信息栏 */
UIKIT_EXTERN CGFloat const LJKProfileHeader_InfoView_Height;



