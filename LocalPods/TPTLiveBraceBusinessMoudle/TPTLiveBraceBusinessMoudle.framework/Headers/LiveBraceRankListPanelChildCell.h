//
//  LiveBraceRankListPanelChildCell.h
//  TPTLiveBraceBusinessMoudle
//
//  Created by 田建波 on 2022/9/2.
//

//榜单用户列表cell
#import <TPTCoreMoudle/TPTCoreMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LiveBraceRankListPanelChildCell : UICommonTableCell

/// 关注
@property(nonatomic, strong, readonly)UIButton * followButton;
/// 点击头像、开播或者不开播
@property(nonatomic, strong, readonly)UIButton * averButton;

@end

NS_ASSUME_NONNULL_END
