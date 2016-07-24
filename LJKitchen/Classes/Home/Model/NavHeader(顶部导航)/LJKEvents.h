//
//  LJKEvents.h
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//
//  推广(M)

#import <Foundation/Foundation.h>
@class LJKAuthor;

@interface LJKEvents : NSObject
/** 是否被推广 */
@property (nonatomic, assign) BOOL is_promoted;
/** （推广专题?）id */
@property (nonatomic, copy) NSString *ID;
/** （推广专题?）标题 */
@property (nonatomic, copy) NSString *name;
/** （推广专题?）作者 */
@property (nonatomic, strong) LJKAuthor *author;
@end
