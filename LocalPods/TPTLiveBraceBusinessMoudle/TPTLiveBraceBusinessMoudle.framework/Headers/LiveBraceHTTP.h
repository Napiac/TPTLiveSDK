//
//  LiveBraceHTTP.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

#import <Foundation/Foundation.h>

@class LiveBraceRankListUserModel;
@class HTTPPage;
@class LiveBraceMoreLiveMenuModel;
@class LiveBraceMoreLiveRecommendModel;
@class LiveBraceMoreAdModel;
@class LiveUserInfoModel;
@class LiveEndInfoModel;
@class LiveBracePKSeasonRankingModel;
NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceHTTP : NSObject


/// 榜单
+ (void)fetchHourRankListWithType:(NSString *)type
                       withUserId:(nonnull NSString *)userId
                           result:(nonnull void (^)(NSArray<LiveBraceRankListUserModel *> * list,
                                                    LiveBraceRankListUserModel * model,
                                                    NSTimeInterval next_award_time,
                                                    NSString * top_point_area))handler;

/// 关注/取消 用户
/// @param userId 当前的主播ID
/// @param isFollow 是否关注
/// @param handler 回执
+ (void)prepareFollowUserWithUserId:(NSString *)userId
                           isFollow:(BOOL)isFollow
                             result:(void (^) (BOOL success, NSString * message))handler;


///  查询直播间推荐菜单列表
/// - Parameter complate: 回调数组
+ (void)fetchLiveMorePageMenuListComplate:(void (^)(NSArray <LiveBraceMoreLiveMenuModel *>* menus))complate;

/// 获取推荐直播间数据
/// @param menuId 菜单ID
/// @param page 分页
/// @param handler 回调
+ (void)fetchMoreLiveDataListWithMenuId:(NSString *)menuId
                                   page:(HTTPPage *)page
                                handler:(void (^)(NSArray <LiveBraceMoreLiveRecommendModel *>* list))handler;
/// 更多直播banner
/// @param handler 回执
+ (void)queryMoreLiveBannerResult:(void (^) (BOOL success, NSArray * dataSource))handler;


/**
 主播关播 获取详情直播信息
 showid：主播id
 closeType ：关播方式 挂机关播时 传“1”
 completion：完成block回调
 */
+ (void)getAnchorEndLiveDetailWithShowid:(NSString *)showid closeType:(NSInteger)colseType completion:(void(^)(BOOL success, LiveEndInfoModel *model))completion;

/**
 获取某个用户的信息
 userId：该用户的id
 roomId：直播间id
 completion：完成block回调
 */
+ (void)getUserInfoWithUserId:(NSString *)userId roomId:(NSString * _Nullable)roomId completion:(void (^)(BOOL success, LiveUserInfoModel *model))completion;

/**
 观众退出直播间 查询推荐的直播间列表
 roomuserid：主播用户id
 completion：完成block回调
 */
+ (void)getOutRoomRecommendsWithRoomuserid:(NSString *)roomuserid completion:(void(^)(BOOL success, NSArray *array))completion;

/**
 获取 本场收礼记录
 userId：主播用户id
 roomUserID: 直播间主播ID
 completion：完成block回调
 */
+ (void)getReceivedGiftRecordWithUserId:(NSString *)userId
                             roomUserID:(NSString *)roomUserID
                                  pages:(HTTPPage *)pages
                             completion:(void(^)(BOOL success, NSArray *array, NSString *totalHeat))completion;

/// 获取pk赛季榜单
/// @param queryId 被查询用户的id
/// @param completion 完成block回掉
+ (void)getSeasonRankingWithQueryId:(NSString *)queryId completion:(void (^)(BOOL, LiveBracePKSeasonRankingModel * _Nullable))completion;


@end

NS_ASSUME_NONNULL_END
