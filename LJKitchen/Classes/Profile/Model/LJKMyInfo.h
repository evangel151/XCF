//
//  LJKMyInfo.h
//  LJKitchen
//
//  Created by  a on 16/6/15.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LJKAuthorDetail;

@interface LJKMyInfo : NSObject


+ (LJKAuthorDetail *)info;
+ (void)updateInfoWithNewInfo:(LJKAuthorDetail *)info;

@end
