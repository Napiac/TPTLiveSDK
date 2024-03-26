//
//  UIView+Lock.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Lock)

/// 加载中覆盖的UI 约束大小和view相同 Defalut: LockActivityIndicatorView
@property(nonatomic,strong)UIView * coverView;

/// 锁定后是否运行交互 Default:NO
@property(nonatomic,assign)BOOL lock_canTouch;

/// 是否锁定 Default:NO
@property(nonatomic,assign)BOOL isLock;

@end

NS_ASSUME_NONNULL_END
