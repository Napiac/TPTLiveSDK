//
//  ItemTapRefreshView.h
//  TPTCoreMoudle
//
//  Created by wansheng on 2022/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemTapRefreshView : UIImageView

- (void)setupImage;
- (void)setupWhiteImage;
- (void)setupBlackImage;
- (void)startRefreshAnimation;
- (void)stopRefreshAnimation;

@end

NS_ASSUME_NONNULL_END
