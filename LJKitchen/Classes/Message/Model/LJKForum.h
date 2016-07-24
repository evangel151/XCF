//
//  LJKForum.h
//  LJKitchen
//
//  Created by  a on 16/6/22.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  论坛(M)

#import <Foundation/Foundation.h>
@class LJKAuthor;

@interface LJKForum : NSObject
@property (nonatomic, strong) NSArray <LJKAuthor *> *latest_authors; // 最后发表主题的作者
@property (nonatomic, copy) NSString *name; // 社区名称
@property (nonatomic, copy) NSString *desc; // 最后主题的内容
@end
