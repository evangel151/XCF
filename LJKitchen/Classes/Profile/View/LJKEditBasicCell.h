//
//  LJKEditBasicCell.h
//  LJKitchen
//
//  Created by  a on 16/6/29.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJKEditBasicCell : UITableViewCell
/** 占位符 */
@property (nonatomic, copy) NSString *placeHolder;
/** 当前文本 */
@property (nonatomic, copy) NSString *currentName;

/** 编辑回调 */
@property (nonatomic, copy) void (^editingTextBlock)(NSString *);
@end
