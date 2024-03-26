//
//  DrawerMenuVisualStateManager.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

typedef NS_ENUM(NSInteger, DrawerAnimationType){
    DrawerAnimationTypeNone,
    DrawerAnimationTypeSlide,
    DrawerAnimationTypeSlideAndScale,
    DrawerAnimationTypeSwingingDoor,
    DrawerAnimationTypeParallax,
};

#import <Foundation/Foundation.h>
#import "UIGeneralDrawerMenuController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DrawerMenuVisualStateManager : NSObject

@property(nonatomic, assign)DrawerAnimationType leftDrawerAnimationType;
@property(nonatomic, assign)DrawerAnimationType rightDrawerAnimationType;

+ (DrawerMenuVisualStateManager *)sharedManager;
- (DrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(DrawerMenuSide)drawerSide;

@end

NS_ASSUME_NONNULL_END
