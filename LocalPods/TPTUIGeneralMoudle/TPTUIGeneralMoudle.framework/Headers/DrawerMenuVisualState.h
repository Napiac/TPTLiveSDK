//
//  DrawerMenuVisualState.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

#import <Foundation/Foundation.h>
#import "UIGeneralDrawerMenuController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawerMenuVisualState : NSObject
+ (DrawerControllerDrawerVisualStateBlock)slideAndScaleVisualStateBlock;

+ (DrawerControllerDrawerVisualStateBlock)slideVisualStateBlock;

+ (DrawerControllerDrawerVisualStateBlock)swingingDoorVisualStateBlock;

+ (DrawerControllerDrawerVisualStateBlock)parallaxVisualStateBlockWithParallaxFactor:(CGFloat)parallaxFactor;
@end

NS_ASSUME_NONNULL_END
