//
//  LiveEndMoreRecommendViewController.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/9/20.
// 主播已结束直播 更多推荐直播vc

#import <TPTCoreMoudle/UICommonViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveEndMoreRecommendViewController : UICommonViewController

@property (nonatomic, copy) NSString *userId; ///主播的id
@property (nonatomic, copy) NSString *watchCount; ///观看人数

@end

NS_ASSUME_NONNULL_END
