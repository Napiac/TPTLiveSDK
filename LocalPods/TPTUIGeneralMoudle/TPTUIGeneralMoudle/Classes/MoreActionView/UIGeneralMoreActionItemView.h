//
//  UIGeneralMoreActionItemView.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import <UIKit/UIKit.h>
#import <TPTCoreMoudle/UICommonCollectionItem.h>
NS_ASSUME_NONNULL_BEGIN

///底部more itemView
@interface UIGeneralMoreActionItemView : UICommonCollectionItem
///标题label
@property(nonatomic, strong)UILabel *titleLabel;
///图标label
@property(nonatomic, strong)UIImageView *iconImageView;

@end

NS_ASSUME_NONNULL_END
