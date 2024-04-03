//
//  LiveBraceExitLiveRecommendView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/10/10.
//  用户 退出直播间 推荐更多直播view

#import <TPTCoreMoudle/UICommonView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceExitLiveRecommendView : UICommonView
@property (nonatomic, copy) NSString *userId;

- (void)showExitLiveRecommendView;
- (void)quitCurrentLiveRoom;
+ (instancetype)createView;
@end

NS_ASSUME_NONNULL_END
