//
//  APPJSONDataCacheHandler.h
//  TPTManagerMoudle
//
//  Created by Napiac on 2023/2/8.
//

/// 在sqlite中存储JSON数据
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APPJSONDataCacheHandler : NSObject

/// 向table中插入数据
/// - Parameters:
///   - table: 表名
///   - keyword: 针对JSON数据的关键字
///   - json: json
+ (BOOL)insertDataToDBWithTableName:(NSString *)table
                 contentKeywordText:(NSString *)keyword
                        contentJSON:(id)json;
/// 向table中插入数据
/// - Parameters:
///   - table: 表名
///   - keyword: 针对JSON数据的关键字
///   - json: json
///   - clear: 退出登录是否需要清空数据
+ (BOOL)insertDataToDBWithTableName:(NSString *)table
                 contentKeywordText:(NSString *)keyword
                        contentJSON:(id)json
                        logoutClear:(BOOL)clear;



/// 读取JSON数据
/// - Parameter table: 表名
+ (NSArray *)readJSONDataWithTableName:(NSString *)table;





/// 针对表里面的keyword读取JSON数据
/// - Parameters:
///   - table: 表名
///   - keyword: keyword
+ (NSArray *)readJSONDataWithTableName:(NSString *)table
                           withKeyword:(NSString *)keyword;



/// 清空表数据
/// - Parameter table: 表名
+ (BOOL)clearDataWithTable:(NSString *)table;



/// 针对表里面的keyword清空数据
/// - Parameters:
///   - table: 表名
///   - keyword: keyword
+ (BOOL)clearDataWithTable:(NSString *)table
               withKeyword:(NSString *)keyword;



/// 清空所有缓存数据
+ (BOOL)clearAllCacheData;
@end

NS_ASSUME_NONNULL_END
