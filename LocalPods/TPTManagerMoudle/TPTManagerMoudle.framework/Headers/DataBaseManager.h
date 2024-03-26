//
//  DataBaseManager.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/27.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataBaseManager : NSObject
+ (void)end;
+ (void)clean;
+ (NSString *)dbFilePath;
@end







@interface DataBaseManager (DB)
+ (FMDatabase *)startDB;

/// 打开状态
+ (BOOL)dbOpenStatus;
/// table是否存在
/// - Parameter table: name
+ (BOOL)tableExists:(NSString *)table;
/// 增删改
/// - Parameter sql: SQL
+ (BOOL)dbUpdate:(NSString *)sql;
/// 查询
/// - Parameter sql: SQL 
+ (NSArray<NSDictionary *> *)dbQuery:(NSString*)sql;
@end









@interface DataBaseManager (DBQueue)
+ (FMDatabaseQueue *)startDBQueue;
@end







@interface DataBaseManager (GroupTask)
dispatch_group_t DBGroup(void);
dispatch_queue_t DBQueue(void);
void DBGroupEnter(void);
void DBGroupLeave(void);
void DBGroupWait(void);
void Clean(void);
@end

NS_ASSUME_NONNULL_END
