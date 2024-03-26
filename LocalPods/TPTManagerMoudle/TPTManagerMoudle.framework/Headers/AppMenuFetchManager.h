//
//  AppMenuFetchManager.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2023/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AppMenuModel;


/// 获取APP内菜单 Manager
@interface AppMenuFetchManager : NSObject

/// 是否使用缓存
/// 默认为YES
@property (nonatomic, assign)BOOL useCache;

/// 是否更新缓存
/// 默认为YES
@property (nonatomic, assign)BOOL updateCache;


/// 菜单列表
/// 如果设置了useCache使用缓存为YES 默认读取缓存列表，否则默认为nil
/// 如果调用了fetchMenuListWithHandler 请求网络数据拿到结果后 会修改这个值
@property (nonatomic, strong, readonly)NSArray <AppMenuModel *>*menuList;



- (instancetype)init NS_UNAVAILABLE;

/// 初始化
/// - Parameter key: 菜单位置标识
+ (instancetype)managerWithMenuKey:(NSString *)key;

/// 获取菜单列表, 请求最新网络数据进行回调
/// - Parameter handler: 回调
- (void)fetchMenuListWithHandler:(void (^)(NSArray <AppMenuModel *>* menus))handler;


@end

NS_ASSUME_NONNULL_END
