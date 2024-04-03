//
//  LiveBraceRankListPanelHeaderView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

//榜单headerview
#import <TPTCoreMoudle/UICommonView.h>

@class JXCategoryTitleView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^endTimeBlock)(void);

@interface LiveBraceRankListPanelHeaderView : UICommonView

@property(nonatomic, strong)JXCategoryTitleView * categoryView;
/// 顶部背景图
@property(nonatomic, strong)UIImageView * topBackgroundImageView;
/// 倒计时结束
@property(nonatomic, copy)endTimeBlock endTimeBlock;
/// 规则
@property(nonatomic, strong)UIButton * ruleButton;
/// 榜单便签值
@property(nonatomic, copy)NSString * rankLabel;
/// 开始倒计时
- (void)startTheTimerWithTime:(NSInteger)totalTime;

@end

NS_ASSUME_NONNULL_END
