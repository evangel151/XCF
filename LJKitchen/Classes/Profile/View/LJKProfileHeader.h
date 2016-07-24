//
//  LJKProfileHeader.h
//  LJKitchen
//
//  Created by  a on 16/6/26.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  个人 - Header （V）


/** header - 回调枚举 */
typedef NS_ENUM(NSInteger, headerDidClickedAction) {
    
    // 顶部
    headerDidClickedActionInfoView     = 1,// 个人信息
    
    // 中部
    headerDidClickedActionCollected    = 10,// 收藏
    headerDidClickedActionOrders       = 11,// 订单
    headerDidClickedActionPreferential = 12,// 优惠
    headerDidClickedActionScore        = 13,// 用户积分
    
    // 底部
    headerDidClickedActionBindMobile   = 6 // 绑定手机
    
};


typedef void (^headerDidClickedBlock)();

#import <UIKit/UIKit.h>
@class LJKMyInfo,LJKAuthorDetail;


@interface LJKProfileHeader : UIView

@property (nonatomic, strong) LJKMyInfo *myInfo;
@property (nonatomic, strong) LJKAuthorDetail *authorDetail;

/** Header各部分view点击后回调 */
@property (nonatomic, copy) headerDidClickedBlock clickBlock;
@end
