//
//  LJKItems.m
//  LJKitchen
//
//  Created by  a on 16/6/17.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKItems.h"
#import "LJKImage.h"
#import "LJKContents.h"

@implementation LJKItems

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (CGFloat)cellHeight {
    // 如果Cell类型为 帖子(1)  菜谱(5) 存在用户头像及说明等附加视图 -> 需要根据文字内容对高度进行计算
    if (self.template == LJKCellTemplateTopic || self.template == LJKCellTemplateRecipe) {
        // 图片高度
        CGFloat imageHeight = self.contents.image.height;
        // 底部视图 主标题高度
        CGFloat titleHeight = [self.contents.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 15 * 3, MAXFLOAT)
                                                                options:NSStringDrawingUsesLineFragmentOrigin
                                                             attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                                context:nil].size.height;
        // 底部视图 副标题高度 
        CGFloat descHeight = [self.contents.desc boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 15 * 2, MAXFLOAT)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]}
                                                              context:nil].size.height;
        // 35 == 底部做过的人labelHeight + padding * 2
        _cellHeight = imageHeight + LJKRecipeCellMarginTitle + titleHeight + LJKRecipeCellMarginTitle2Desc + descHeight + 35;
        
    }
    // 如果Cell 类型为 菜单 + 周刊 + 作品 返回图片高度即可
    else if (self.template == LJKCellTemplateRecipeList || self.template == LJKCellTemplateDish || self.template == LJKCellTemplateWeeklyMagazine) {
        _cellHeight = self.contents.image.height + 5;
    }
    
    return _cellHeight;
}

@end
