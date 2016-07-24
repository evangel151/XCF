//
//  LJKPicture.h
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  图片(M)

#import <Foundation/Foundation.h>

@interface LJKPicture : NSObject
/** 大图片（尺寸600）*/
@property (nonatomic, copy) NSString *bigPhoto;
/** 小图片（尺寸280）*/
@property (nonatomic, copy) NSString *smallPhoto;
/** 标识 */
@property (nonatomic, copy) NSString *ident;
// 图片url 
@property (nonatomic, copy) NSString *url;
@end
