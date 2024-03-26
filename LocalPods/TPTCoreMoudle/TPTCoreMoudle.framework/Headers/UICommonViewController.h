//
//  UICommonViewController.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

///控制器基础类
#import <UIKit/UIKit.h>
#import "InitializationProtocol.h"
#import "UIConfigureProtocol.h"
#import "ItemTapRefreshProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICommonViewController : UIViewController <InitializationProtocol, UIConfigureProtocol, ItemTapRefreshProtocol>

@end

NS_ASSUME_NONNULL_END
