//
//  LJKConstRequest.m
//  LJKitchen
//
//  Created by  a on 16/6/16.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKConstRequest.h"


#pragma mark - 公用
/** 下厨房 - 公用 - (非本人头像点击回调) */
NSString * const LJKRequestKitchenAuthorPage = @"http://www.xiachufang.com/cook/10020872/";


#pragma mark - 首页
#pragma mark Header
/** 下厨房 - 导航数据 */
NSString * const LJKRequestKitchenNav = @"http://api.xiachufang.com/v2/init_page_v5.json?version=5.1.1&timezone=Asia%2FShanghai&api_sign=8436824b4ec402b228bf20028d49c9b5&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=7UnwJ-JkQ36hbfrMRoL0fA";
/** 下厨房 - 首页 - 顶部left  - 排行榜 (webView) */
NSString * const LJKRequestKitchenRankingList = @"http://www.xiachufang.com/page/top-list/";
/** 下厨房 - 首页 - 顶部right - 关注动态 */
NSString * const LJKRequestKitchenFeeds = @"http://api.xiachufang.com/v2/account/feeds_v3.json?offset=0&origin=iphone&api_sign=5682ea5db42972d13cc17bc1401000fe&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=10&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页 - NavButtons - 菜谱分类 (webView) */
NSString * const LJKRequestKitchenRecipeCategory = @"http://www.xiachufang.com/page/app-category/";
/** 下厨房 - 首页 - NavButtons - 买买买 */
NSString * const LJKRequestKitchenBuy = @"http://api.xiachufang.com/v2/explore/buybuybuy.json?cursor=&origin=iphone&api_sign=69199b50e09c797910ee8a05b5e89fbc&sk=7UnwJ-JkQ36hbfrMRoL0fA&size=20&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";

/** 下厨房 - 首页 - scrollView - 三餐基本信息(晚餐) */
NSString * const LJKRequestKitchenSupper = @"http://api.xiachufang.com/v2/events/show.json?id=100131208&sk=EhUpkVYBSoOT9qAapL0BUw&api_sign=fc3bea5063ae11b5678a511fafbaee63&_ts=1466594953.675698&origin=iphone&api_key=07397197043fafe11ce5c65c10febf84&location_code=156320900000000&version=5.5.0&nonce=964A8984-A928-4236-A749-6E3E68341103";
/** 下厨房 - 首页 - scrollView - 三餐作品信息(collectionCell)(晚餐) */
NSString * const LJKRequestKitchenSupperDishes = @"http://api.xiachufang.com/v2/events/100131208/dishes_order_by_hot_v2.json?api_sign=de3babff780130551cabd96e16e7ee46&limit=18&sk=EhUpkVYBSoOT9qAapL0BUw&timestamp=1466601380&nonce=BC718253-163F-467A-AB0B-C27F040388E7&api_key=07397197043fafe11ce5c65c10febf84&version=5.5.0&_ts=1466601381.014687&dish_size=360w_360h&offset=0&location_code=156320900000000&detail=true&origin=iphone";


#pragma mark Cell 主体
/** 下厨房 - 首页Cell数据 */
NSString * const LJKRequestKitchenCell = @"http://api.xiachufang.com/v2/issues/list.json?cursor=&api_key=07397197043fafe11ce5c65c10febf84&size=2&sk=EhUpkVYBSoOT9qAapL0BUw&api_sign=51332747ce48a674bcf0397392410b74&_ts=1465544264.130416&origin=iphone&version=5.5.0&timezone=Asia%2FShanghai&location_code=156320900000000&nonce=F5533FD9-6417-4335-962D-D92D5319250C";
/** 下厨房 - 首页Cell - 上拉加载更多数据 */
NSString * const LJKRequestKitchenCellMore = @"http://api.xiachufang.com/v2/issues/list.json?cursor=&origin=iphone&api_sign=069310ae4fc0b866207dba71320f1c13&sk=7UnwJ-JkQ36hbfrMRoL0fA&size=2&timezone=Asia%2FShanghai&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板2 菜单详情 */
NSString * const LJKRequestKitchenRecipeList = @"http://api.xiachufang.com/v2/recipe_lists/show.json?origin=iphone&id=101554496&api_sign=9b01343de4bc0f61a5b2f051227d00f9&pic_size=720&sk=7UnwJ-JkQ36hbfrMRoL0fA&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板2 菜单内菜谱理由数据 */
NSString * const LJKRequestKitchenRecipeReason = @"http://api.xiachufang.com/v2/recipe_lists/100072887/recipes_v2.json?offset=0&origin=iphone&api_sign=2057b55a66e4d86a9284232741762f0e&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=20&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板4 作品数据 */
NSString * const LJKRequestKitchenDish = @"http://api.xiachufang.com/v2/dishes/show_v2.json?version=5.1.1&id=115246351&api_sign=b3771cf94fa48e3a064247e5ae0610ea&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=7UnwJ-JkQ36hbfrMRoL0fA";
/** 下厨房 - 首页Cell(跳转) - 模板5 菜谱详情 */
NSString * const LJKRequestKitchenRecipe = @"http://api.xiachufang.com/v2/recipes/show_v2.json?origin=iphone&mode=full&id=101773324&api_sign=6332fd2dc5517a725cc5a7fb8e58ea5e&sk=7UnwJ-JkQ36hbfrMRoL0fA&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板5 菜谱id数组数据 */
NSString * const LJKRequestKitchenRecipeIDs = @"http://api.xiachufang.com/v2/recipes/101773324/dishes_v2.json?detail=false&offset=0&origin=iphone&api_sign=43b447f66fff40e58f39d1aa7b6aab0e&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=4&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板5 菜谱内作品详细数据 */
NSString * const LJKRequestKitchenRecipeDish = @"http://api.xiachufang.com/v2/dishes/lookup_v2.json?version=5.1.1&id=115422648%2C115406797%2C115405331%2C115400878&api_sign=ca8aa5cbae7ce01e2c705e4cef02c0ac&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=7UnwJ-JkQ36hbfrMRoL0fA";
/** 下厨房 - 首页Cell(跳转) - 模板5 菜谱“被加入的菜单”数据 */
NSString * const LJKRequestKitchenAddedRecipeList = @"http://api.xiachufang.com/v2/recipes/101773324/related_recipe_lists_v2.json?detail=true&offset=0&origin=iphone&api_sign=13227ccd1adc16087e67960be8b45457&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=2&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 首页Cell(跳转) - 模板5 菜谱推广Url */
NSString * const LJKRequestKitchenSpread = @"http://simplecms.xiachufang.com/posts/1054/?ref=20160710dacu_recipe";


#pragma mark - 市集
/** 下厨房 - 商品详情 */
NSString * const LJKRequestGoods = @"http://api.xiachufang.com/v2/goods/show_v2.json?version=5.1.1&id=3157&api_sign=e353a21329147e9e712b4ff7758d4796&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=7UnwJ-JkQ36hbfrMRoL0fA";


#pragma mark - 社交
/** 下厨房 - 社区 */
NSString * const LJKRequestCommunity = @"http://api.xiachufang.com/v2/social/init_page.json?origin=iphone&longitude=114.918727&api_sign=bcd62c6e9e0c9b70f1c60719c0b96082&sk=7UnwJ-JkQ36hbfrMRoL0fA&latitude=22.806659&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";
/** 下厨房 - 社区(帖子)  */
NSString * const LJKRequestTopic = @"http://api.xiachufang.com/v2/forums/2/topics.json?offset=0&origin=iphone&api_sign=2057b55a66e4d86a9284232741762f0e&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=20&version=5.1.1&api_key=0f9f79be1dac5f003e7de6f876b17c00";

/** 下厨房 - 底部Footer(厨友社)  */
NSString * const LJKRequestFooterCookerClub = @"http://www.xiachufang.com/recipe/101823025/";

#pragma mark - Profile
/** 下厨房 - 用户信息 */
NSString * const LJKAuthorInfo = @"http://api.xiachufang.com/v2/users/show.json?origin=iphone&api_sign=fa3963bc5a16b347e4f7d4ccf2896330&pic_size=160&sk=7UnwJ-JkQ36hbfrMRoL0fA&version=5.1.1&user_id=105223583&api_key=0f9f79be1dac5f003e7de6f876b17c00";

/** 下厨房 - 用户作品 */
NSString * const LJKAuthorDish = @"http://api.xiachufang.com/v2/dishes/created_by_user.json?detail=true&offset=0&origin=iphone&api_sign=5d8e211b92c5d1e45c214946cc5362a5&sk=7UnwJ-JkQ36hbfrMRoL0fA&limit=18&version=5.1.1&user_id=105223583&api_key=0f9f79be1dac5f003e7de6f876b17c00";



