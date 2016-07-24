//
//  LJKReviewPhoto.h
//  LJKitchen
//
//  Created by  a on 16/7/5.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  评价图片(M)

#import <Foundation/Foundation.h>

@interface LJKReviewPhoto : NSObject <NSCoding>
/** 图片地址 */
@property (nonatomic, copy) NSString *url;
/** 标识 */
@property (nonatomic, copy) NSString *ident;
@end
