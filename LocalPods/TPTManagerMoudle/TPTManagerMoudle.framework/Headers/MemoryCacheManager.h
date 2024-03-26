//
//  MemoryCacheManager.h
//  TPTManagerMoudle
//
//  Created by wangyin on 2022/8/12.
//

#import <Foundation/Foundation.h>
#import "APPConfig.h"
#import "URLConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MemoryCacheManager : NSObject

@property(nonatomic, strong, readonly)APPConfig *appConfig;
@property(nonatomic, strong, readonly)URLConfig *urlConfig;


+ (instancetype)shared;

/// 保存app配置
/// @param params 参数
- (BOOL)saveAppConfigWithParams:(NSDictionary *)params;

/// 保存url配置
/// @param params 参数
- (BOOL)saveUrlConfigWithParams:(NSDictionary *)params;

/// 清理app配置缓存
- (BOOL)clearAppConfig;

/// 清理url配置缓存
- (BOOL)clearUrlConfig;


@end

NS_ASSUME_NONNULL_END
