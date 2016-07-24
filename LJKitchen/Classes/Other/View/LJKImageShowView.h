//
//  LJKImageShowView.h
//  LJKitchen
//
//  Created by  a on 16/7/1.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  图片轮播器 

#import <UIKit/UIKit.h>

typedef void (^ShowImageBlock)(NSUInteger, CGRect);

@interface LJKImageShowView : UIView

/** 图片展示类型 */
@property (nonatomic, assign) LJKShowViewType type;
/** 图片数据 */
@property (nonatomic, strong) NSArray *imageArray;
/** 存储cell内图片轮播器滚动位置 */
@property (nonatomic, assign) CGFloat imageViewCurrentLocation;
/** 当前图片下标 */
@property (nonatomic, assign) NSUInteger currentIndex;
/** cell滚动回调 */
@property (nonatomic, copy) void (^imageViewDidScrolledBlock)(CGFloat);
/** 图片点击回调 */
@property (nonatomic, copy) ShowImageBlock showImageBlock;

/** 快速创建 */
+ (instancetype)imageShowViewWithShowImageBlock:(ShowImageBlock)block;

@end
