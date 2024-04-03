//
//  LiveEndMoreLiveHeadView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by wansheng on 2022/9/20.
//  直播间 关播页面更多直播 headerview

#import <TPTCoreMoudle/UICommonCollectionReusableView.h>
@class LiveUserInfoModel;

NS_ASSUME_NONNULL_BEGIN

@interface LiveEndMoreLiveHeadView : UICommonCollectionReusableView

@property (nonatomic, strong) LiveUserInfoModel *userInfoModel;

@end

NS_ASSUME_NONNULL_END
