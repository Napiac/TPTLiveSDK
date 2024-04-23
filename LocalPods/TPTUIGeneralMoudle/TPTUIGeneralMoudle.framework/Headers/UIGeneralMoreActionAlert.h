//
//  UIGeneralMoreActionModal.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/25.
//

#import "UIGeneralMoreActionItemModel.h"
#import <TPTCoreMoudle/UICommonView.h>

NS_ASSUME_NONNULL_BEGIN

/**底部弹出的更多视图*/
@interface UIGeneralMoreActionAlert : UICommonView

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        items:(NSArray <UIGeneralMoreActionItemModel *>*)items;


- (void)showInView:(UIView *)view;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
