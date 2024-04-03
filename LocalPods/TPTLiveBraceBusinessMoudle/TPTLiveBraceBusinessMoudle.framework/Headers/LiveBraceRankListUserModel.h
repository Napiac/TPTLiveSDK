//
//  LiveBraceRankListUserModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

//榜单用户model
#import <Foundation/Foundation.h>
@class LiveBracePKSeasonRankingOtherListModel;

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRankListUserModel : NSObject

@property(nonatomic, copy)NSString * room_user_id;

@property(nonatomic, copy)NSString * head_portrait;
@property(nonatomic, copy)NSString * head_portrait_box;
@property(nonatomic, assign)BOOL is_follow;
@property(nonatomic, copy)NSString * nick_name;
@property(nonatomic, copy)NSString * point;
@property(nonatomic, assign)BOOL is_start;
/// 排名
@property(nonatomic, copy)NSString * rank;
/// 榜单值标签
@property(nonatomic, copy)NSString * label;

#pragma mark-
#pragma mark-custom

/// 是否在当前直播间
@property(nonatomic, assign)BOOL isCurrentRoom;

/// 排名文字颜色
@property(nonatomic, copy)NSString * rankColorName;


- (LiveBracePKSeasonRankingOtherListModel *)changeToPKSeasonModel;


@end

NS_ASSUME_NONNULL_END
