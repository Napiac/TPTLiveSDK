//
//  DrawerMenuVisualStateManager.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

#import "DrawerMenuVisualStateManager.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawerMenuVisualState.h"

@implementation DrawerMenuVisualStateManager

+ (DrawerMenuVisualStateManager *)sharedManager {
    static DrawerMenuVisualStateManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DrawerMenuVisualStateManager alloc] init];
        [_sharedManager setLeftDrawerAnimationType:DrawerAnimationTypeParallax];
        [_sharedManager setRightDrawerAnimationType:DrawerAnimationTypeParallax];
    });
    
    return _sharedManager;
}

- (DrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(DrawerMenuSide)drawerSide {
    DrawerAnimationType animationType;
    if (drawerSide == DrawerMenuSideLeft) {
        animationType = self.leftDrawerAnimationType;
    } else {
        animationType = self.rightDrawerAnimationType;
    }
    
    DrawerControllerDrawerVisualStateBlock visualStateBlock = nil;
    switch (animationType) {
        case DrawerAnimationTypeSlide:
            visualStateBlock = [DrawerMenuVisualState slideVisualStateBlock];
            break;
        case DrawerAnimationTypeSlideAndScale:
            visualStateBlock = [DrawerMenuVisualState slideAndScaleVisualStateBlock];
            break;
        case DrawerAnimationTypeParallax:
            visualStateBlock = [DrawerMenuVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
            break;
        case DrawerAnimationTypeSwingingDoor:
            visualStateBlock = [DrawerMenuVisualState swingingDoorVisualStateBlock];
            break;
        default:
            visualStateBlock = ^(UIGeneralDrawerMenuController * drawerController, DrawerMenuSide drawerSide, CGFloat percentVisible) {
                
                UIViewController * sideDrawerViewController;
                CATransform3D transform;
                CGFloat maxDrawerWidth = 0.f;
                
                if (drawerSide == DrawerMenuSideLeft) {
                    sideDrawerViewController = drawerController.leftDrawerViewController;
                    maxDrawerWidth = drawerController.maximumLeftDrawerWidth;
                } else if (drawerSide == DrawerMenuSideRight) {
                    sideDrawerViewController = drawerController.rightDrawerViewController;
                    maxDrawerWidth = drawerController.maximumRightDrawerWidth;
                }
                
                if (percentVisible > 1.0) {
                    transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
                    if (drawerSide == DrawerMenuSideLeft) {
                        transform = CATransform3DTranslate(transform, maxDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
                    } else if (drawerSide == DrawerMenuSideRight) {
                        transform = CATransform3DTranslate(transform, -maxDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
                    }
                } else {
                    transform = CATransform3DIdentity;
                }
                [sideDrawerViewController.view.layer setTransform:transform];
            };
            break;
    }
    return visualStateBlock;
}

@end
