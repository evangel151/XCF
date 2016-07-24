//
//  LJKCommentsTool.m
//  LJKitchen
//
//  Created by  a on 16/6/26.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKCommentsTool.h"
#import "LJKTopicComment.h"
#import <MJExtension.h>

@implementation LJKCommentsTool

static NSMutableArray *_commentArray;

+ (NSArray *)totalComments {
    // 从 (fake)comment.data 中加载
    _commentArray = [NSKeyedUnarchiver unarchiveObjectWithFile:LJKCommentPath];
    if (!_commentArray.count) {
        _commentArray = [NSMutableArray array];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                         pathForResource:@"comment.plist"
                                                                         ofType:nil]];
        _commentArray = [LJKTopicComment mj_objectArrayWithKeyValuesArray:dict[@"content"][@"comments"]];
    }
    return _commentArray;
}

@end
