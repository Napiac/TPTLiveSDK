//
//  TPTDBDebug.h
//  TPTBlackBoxTestingMoudle
//
//  Created by Napiac on 2023/6/12.
//  Copyright © 2023 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTDBDebug : NSObject

+ (NSString *)fetchTableNamesHTMLString:(NSString *)dbPath;

+ (NSArray *)queryTableData:(NSString *)dbPath tableName:(NSString *)tableName;

+ (NSDictionary *)queryDatabaseSchema:(NSString *)dbPath;

+ (NSDictionary *)executeSQL:(NSString *)dbPath sql:(NSString *)sqlStr;
@end

NS_ASSUME_NONNULL_END
