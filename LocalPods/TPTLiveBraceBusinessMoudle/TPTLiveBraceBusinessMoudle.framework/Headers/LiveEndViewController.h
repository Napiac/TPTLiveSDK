//
//  LiveEndViewController.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/9/19.
//  主播端 结束直播vc

#import <TPTCoreMoudle/UICommonViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveEndViewController : UICommonViewController

@property (nonatomic, copy) NSString *showId; ///直播间的showid
@property (nonatomic, copy) NSString *userId; ///主播的id
@property (nonatomic, copy) NSString *totalLiveTime;///直播时间段、时长

- (void)setLiveEndViewParams:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
