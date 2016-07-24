//
//  LJKRecipeInstruction.h
//  LJKitchen
//
//  Created by  a on 16/6/20.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKRecipeInstruction : NSObject
/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 文字描述 */
@property (nonatomic, copy) NSString *text;
/** 步骤 */
@property (nonatomic, assign) NSUInteger step;
/** 标识（图片名字） */
@property (nonatomic, copy) NSString *ident;
/** 步骤cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;
@end
