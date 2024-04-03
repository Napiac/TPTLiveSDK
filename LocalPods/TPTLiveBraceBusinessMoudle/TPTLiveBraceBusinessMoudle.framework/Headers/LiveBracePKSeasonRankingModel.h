//
//  LiveBracePKSeasonRankingModel.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by dfb on 2022/12/15.
//pk赛季排行榜model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LiveBracePKSeasonRankingMyModel;
@class LiveBracePKSeasonRankingOtherListModel;
@interface LiveBracePKSeasonRankingModel : NSObject

@property (nonatomic, strong) LiveBracePKSeasonRankingMyModel *user;
@property (nonatomic, strong) NSArray<LiveBracePKSeasonRankingOtherListModel*> *list;
@property (nonatomic, assign) NSInteger isOpen;
@end

@interface LiveBracePKSeasonRankingMyModel : NSObject
@property (nonatomic, assign) NSInteger totalStar;
@property (nonatomic, assign) NSInteger currentStar;
@property (nonatomic, assign) NSInteger nexStarExperience;
@property (nonatomic, assign) NSInteger nexStarExperienceTotal;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger winCount;
@property (nonatomic, copy) NSString *rank;//排名
@property (nonatomic, assign) NSInteger winTotalCount;
@property (nonatomic, copy) NSString *winRatio;
@property (nonatomic, copy) NSString *head_portrait;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *time;
@end

@interface LiveBracePKSeasonRankingOtherListModel : NSObject
@property (nonatomic, copy) NSString *head_portrait;
@property (nonatomic, copy) NSString *nick_name;
///是否开播
@property (nonatomic, assign) BOOL is_showing;
@property (nonatomic, copy) NSString *user_id;
///落后经验值
@property (nonatomic, copy) NSString *backward_exp;
@property (nonatomic, assign) NSInteger rank;
@end

NS_ASSUME_NONNULL_END
