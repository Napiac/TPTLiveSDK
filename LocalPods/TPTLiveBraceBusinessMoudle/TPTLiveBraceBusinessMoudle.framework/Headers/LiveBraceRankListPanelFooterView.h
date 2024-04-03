//
//  LiveBraceRankListPanelFooterView.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/5.
//

//榜单底部view
#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import <TPTCoreMoudle/UICommonView.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRankListPanelFooterView : UICommonView

/// 支持
@property(nonatomic, strong, readonly)UIButton * supportButton;

- (void)updatePointString;

@end

NS_ASSUME_NONNULL_END
