//
//  UIGeneralDrawerMenuController.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//


#import "UIGeneralDrawerMenuController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+DrawerMenuController.h"

CGFloat const DrawerMenuDefaultWidth = 280.0f;
CGFloat const DrawerMenuDefaultAnimationVelocity = 840.0f;

NSTimeInterval const DrawerMenuDefaultFullAnimationDelay = 0.10f;

CGFloat const DrawerMenuDefaultBounceDistance = 50.0f;

NSTimeInterval const DrawerMenuDefaultBounceAnimationDuration = 0.2f;
CGFloat const DrawerMenuDefaultSecondBounceDistancePercentage = .25f;

CGFloat const DraweMenurDefaultShadowRadius = 10.0f;
CGFloat const DrawerMenuDefaultShadowOpacity = 0.8;

NSTimeInterval const DrawerMenuMinimumAnimationDuration = 0.15f;

CGFloat const DrawerMenuBezelRange = 20.0f;

CGFloat const DrawerMenuPanVelocityXAnimationThreshold = 200.0f;

/** The amount of overshoot that is panned linearly. The remaining percentage nonlinearly asymptotes to the max percentage. */
CGFloat const DrawerMenuOvershootLinearRangePercentage = 0.75f;

/** The percent of the possible overshoot width to use as the actual overshoot percentage. */
CGFloat const DrawerMenuOvershootPercentage = 0.1f;

typedef BOOL (^DrawerGestureShouldRecognizeTouchBlock)(UIGeneralDrawerMenuController * drawerController, UIGestureRecognizer * gesture, UITouch * touch);
typedef void (^DrawerGestureCompletionBlock)(UIGeneralDrawerMenuController * drawerController, UIGestureRecognizer * gesture);

static CAKeyframeAnimation * bounceKeyFrameAnimationForDistanceOnView(CGFloat distance, UIView * view) {
	CGFloat factors[32] = {0, 32, 60, 83, 100, 114, 124, 128, 128, 124, 114, 100, 83, 60, 32,
		0, 24, 42, 54, 62, 64, 62, 54, 42, 24, 0, 18, 28, 32, 28, 18, 0};
    
	NSMutableArray *values = [NSMutableArray array];
    
	for (int i=0; i<32; i++)
	{
		CGFloat positionOffset = factors[i]/128.0f * distance + CGRectGetMidX(view.bounds);
		[values addObject:@(positionOffset)];
	}
    
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
	animation.repeatCount = 1;
	animation.duration = .8;
	animation.fillMode = kCAFillModeForwards;
	animation.values = values;
	animation.removedOnCompletion = YES;
	animation.autoreverses = NO;
    
	return animation;
}

static NSString *DrawerLeftMenuDrawerKey = @"DrawerLeftMenuDrawer";
static NSString *DrawerRightMenuDrawerKey = @"DrawerRightMenuDrawer";
static NSString *DrawerCenterControllerKey = @"DrawerCenterController";
static NSString *DrawerOpenSideKey = @"DrawerOpenSide";

@interface DrawerCenterContainerView : UIView
@property (nonatomic,assign) DrawerOpenCenterInteractionMode centerInteractionMode;
@property (nonatomic,assign) DrawerMenuSide openSide;
@end

@implementation DrawerCenterContainerView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView &&
       self.openSide != DrawerMenuSideNone){
        UINavigationBar * navBar = [self navigationBarContainedWithinSubviewsOfView:self];
        CGRect navBarFrame = [navBar convertRect:navBar.bounds toView:self];
        if((self.centerInteractionMode == DrawerOpenCenterInteractionModeNavigationBarOnly &&
           CGRectContainsPoint(navBarFrame, point) == NO) ||
           self.centerInteractionMode == DrawerOpenCenterInteractionModeNone){
            hitView = nil;
        }
    }
    return hitView;
}

- (UINavigationBar*)navigationBarContainedWithinSubviewsOfView:(UIView*)view{
    UINavigationBar * navBar = nil;
    for(UIView * subview in [view subviews]){
        if([view isKindOfClass:[UINavigationBar class]]){
            navBar = (UINavigationBar*)view;
            break;
        }
        else {
            navBar = [self navigationBarContainedWithinSubviewsOfView:subview];
            if (navBar != nil) {
                break;
            }
        }
    }
    return navBar;
}
@end

@interface UIGeneralDrawerMenuController () <UIGestureRecognizerDelegate>{
    CGFloat _maximumRightDrawerWidth;
    CGFloat _maximumLeftDrawerWidth;
    UIColor * _statusBarViewBackgroundColor;
}

@property (nonatomic, assign, readwrite) DrawerMenuSide openSide;

@property (nonatomic, strong) UIView * childControllerContainerView;
@property (nonatomic, strong) DrawerCenterContainerView * centerContainerView;
@property (nonatomic, strong) UIView * dummyStatusBarView;

@property (nonatomic, assign) CGRect startingPanRect;
@property (nonatomic, copy) DrawerControllerDrawerVisualStateBlock drawerVisualState;
@property (nonatomic, copy) DrawerGestureShouldRecognizeTouchBlock gestureShouldRecognizeTouch;
@property (nonatomic, copy) DrawerGestureCompletionBlock gestureCompletion;
@property (nonatomic, assign, getter = isAnimatingDrawer) BOOL animatingDrawer;

@end

@implementation UIGeneralDrawerMenuController

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
        [self commonSetup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
	self = [super initWithCoder:aDecoder];
	if (self) {
        [self commonSetup];
	}
	return self;
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController{
    NSParameterAssert(centerViewController);
    self = [super init];
    if(self){
        [self setCenterViewController:centerViewController];
        [self setLeftDrawerViewController:leftDrawerViewController];
        [self setRightDrawerViewController:rightDrawerViewController];
    }
    return self;
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController{
    return [self initWithCenterViewController:centerViewController leftDrawerViewController:leftDrawerViewController rightDrawerViewController:nil];
}

- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController{
    return [self initWithCenterViewController:centerViewController leftDrawerViewController:nil rightDrawerViewController:rightDrawerViewController];
}

- (void)commonSetup{
    [self setMaximumLeftDrawerWidth:DrawerMenuDefaultWidth];
    [self setMaximumRightDrawerWidth:DrawerMenuDefaultWidth];
    
    [self setAnimationVelocity:DrawerMenuDefaultAnimationVelocity];
    
    [self setShowsShadow:YES];
    [self setShouldStretchDrawer:YES];
    
    [self setOpenDrawerGestureModeMask:OpenDrawerGestureModeNone];
    [self setCloseDrawerGestureModeMask:CloseDrawerGestureModeNone];
    [self setCenterHiddenInteractionMode:DrawerOpenCenterInteractionModeNavigationBarOnly];
    
    // set shadow related default values
    [self setShadowOpacity:DrawerMenuDefaultShadowOpacity];
    [self setShadowRadius:DraweMenurDefaultShadowRadius];
    [self setShadowOffset:CGSizeMake(0, -3)];
    [self setShadowColor:[UIColor blackColor]];
    
    // set default bezel range for panGestureReconizer
    [self setBezelPanningCenterViewRange:DrawerMenuBezelRange];
    
    // set defualt panVelocityXAnimationThreshold
    [self setPanVelocityXAnimationThreshold:DrawerMenuPanVelocityXAnimationThreshold];
}

#pragma mark - State Restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [super encodeRestorableStateWithCoder:coder];
    if (self.leftDrawerViewController){
        [coder encodeObject:self.leftDrawerViewController forKey:DrawerLeftMenuDrawerKey];
    }

    if (self.rightDrawerViewController){
        [coder encodeObject:self.rightDrawerViewController forKey:DrawerRightMenuDrawerKey];
    }

    if (self.centerViewController){
        [coder encodeObject:self.centerViewController forKey:DrawerCenterControllerKey];
    }

    [coder encodeInteger:self.openSide forKey:DrawerOpenSideKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    UIViewController *controller;
    DrawerMenuSide openside;

    [super decodeRestorableStateWithCoder:coder];
    
    if ((controller = [coder decodeObjectForKey:DrawerLeftMenuDrawerKey])){
        self.leftDrawerViewController = controller;
    }

    if ((controller = [coder decodeObjectForKey:DrawerRightMenuDrawerKey])){
        self.rightDrawerViewController = controller;
    }

    if ((controller = [coder decodeObjectForKey:DrawerCenterControllerKey])){
        self.centerViewController = controller;
    }

    if ((openside = [coder decodeIntegerForKey:DrawerOpenSideKey])){
        [self openDrawerSide:openside animated:false completion:nil];
    }
}
#pragma mark - Open/Close methods
- (void)toggleDrawerSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    NSParameterAssert(drawerSide!=DrawerMenuSideNone);
    if(self.openSide == DrawerMenuSideNone){
        [self openDrawerSide:drawerSide animated:animated completion:completion];
    }
    else {
        if((drawerSide == DrawerMenuSideLeft &&
           self.openSide == DrawerMenuSideLeft) ||
           (drawerSide == DrawerMenuSideRight &&
           self.openSide == DrawerMenuSideRight)){
            [self closeDrawerAnimated:animated completion:completion];
        }
        else if(completion){
            completion(NO);
        }
    }
}

- (void)closeDrawerAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    [self closeDrawerAnimated:animated velocity:self.animationVelocity animationOptions:UIViewAnimationOptionCurveEaseInOut completion:completion];
}

- (void)closeDrawerAnimated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion{
    if(self.isAnimatingDrawer){
        if(completion){
            completion(NO);
        }
    }
    else {
        [self setAnimatingDrawer:animated];
        CGRect newFrame = self.childControllerContainerView.bounds;
        
        CGFloat distance = ABS(CGRectGetMinX(self.centerContainerView.frame));
        NSTimeInterval duration = MAX(distance/ABS(velocity),DrawerMenuMinimumAnimationDuration);
        
        BOOL leftDrawerVisible = CGRectGetMinX(self.centerContainerView.frame) > 0;
        BOOL rightDrawerVisible = CGRectGetMinX(self.centerContainerView.frame) < 0;
        
        DrawerMenuSide visibleSide = DrawerMenuSideNone;
        CGFloat percentVisble = 0.0;
        
        if(leftDrawerVisible){
            CGFloat visibleDrawerPoints = CGRectGetMinX(self.centerContainerView.frame);
            percentVisble = MAX(0.0,visibleDrawerPoints/self.maximumLeftDrawerWidth);
            visibleSide = DrawerMenuSideLeft;
        }
        else if(rightDrawerVisible){
            CGFloat visibleDrawerPoints = CGRectGetWidth(self.centerContainerView.frame)-CGRectGetMaxX(self.centerContainerView.frame);
            percentVisble = MAX(0.0,visibleDrawerPoints/self.maximumRightDrawerWidth);
            visibleSide = DrawerMenuSideRight;
        }
        
        UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:visibleSide];
        
        [self updateDrawerVisualStateForDrawerSide:visibleSide percentVisible:percentVisble];
        
        [sideDrawerViewController beginAppearanceTransition:NO animated:animated];
        
        [UIView
         animateWithDuration:(animated?duration:0.0)
         delay:0.0
         options:options
         animations:^{
             [self setNeedsStatusBarAppearanceUpdateIfSupported];
             [self.centerContainerView setFrame:newFrame];
             [self updateDrawerVisualStateForDrawerSide:visibleSide percentVisible:0.0];
         }
         completion:^(BOOL finished) {
             [sideDrawerViewController endAppearanceTransition];
             [self setOpenSide:DrawerMenuSideNone];
             [self resetDrawerVisualStateForDrawerSide:visibleSide];
             [self setAnimatingDrawer:NO];
             if(completion){
                 completion(finished);
             }
         }];
    }
}

- (void)openDrawerSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
    NSParameterAssert(drawerSide != DrawerMenuSideNone);
    
    [self openDrawerSide:drawerSide animated:animated velocity:self.animationVelocity animationOptions:UIViewAnimationOptionCurveEaseInOut completion:completion];
}

- (void)openDrawerSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion{
    NSParameterAssert(drawerSide != DrawerMenuSideNone);
    if (self.isAnimatingDrawer) {
        if(completion){
            completion(NO);
        }
    }
    else {
        [self setAnimatingDrawer:animated];
        UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
        if (self.openSide != drawerSide) {
          [self prepareToPresentDrawer:drawerSide animated:animated];
        }
        
        if(sideDrawerViewController){
            CGRect newFrame;
            CGRect oldFrame = self.centerContainerView.frame;
            if(drawerSide == DrawerMenuSideLeft){
                newFrame = self.centerContainerView.frame;
                newFrame.origin.x = self.maximumLeftDrawerWidth;
            }
            else {
                newFrame = self.centerContainerView.frame;
                newFrame.origin.x = 0-self.maximumRightDrawerWidth;
            }
            
            CGFloat distance = ABS(CGRectGetMinX(oldFrame)-newFrame.origin.x);
            NSTimeInterval duration = MAX(distance/ABS(velocity),DrawerMenuMinimumAnimationDuration);
            
            [UIView
             animateWithDuration:(animated?duration:0.0)
             delay:0.0
             options:options
             animations:^{
                 [self setNeedsStatusBarAppearanceUpdateIfSupported];
                 [self.centerContainerView setFrame:newFrame];
                 [self updateDrawerVisualStateForDrawerSide:drawerSide percentVisible:1.0];
             }
             completion:^(BOOL finished) {
                 //End the appearance transition if it already wasn't open.
                 if(drawerSide != self.openSide){
                     [sideDrawerViewController endAppearanceTransition];
                 }
                 [self setOpenSide:drawerSide];
                 
                 [self resetDrawerVisualStateForDrawerSide:drawerSide];
                 [self setAnimatingDrawer:NO];
                 if(completion){
                     completion(finished);
                 }
             }];
        }
    }
}

#pragma mark - Updating the Center View Controller
//If animated is NO, then we need to handle all the appearance calls within this method. Otherwise,
//let the method calling this one handle proper appearance methods since they will have more context
- (void)setCenterViewController:(UIViewController *)centerViewController animated:(BOOL)animated{
    if ([self.centerViewController isEqual:centerViewController]) {
        return;
    }
  
  if (_centerContainerView == nil) {
    //This is related to Issue #152 (https://github.com/mutualmobile/UIGeneralDrawerMenuController/issues/152)
    // also fixed below in the getter for `childControllerContainerView`. Turns out we have
    // two center container views getting added to the view during init,
    // because the first request self.centerContainerView.bounds was kicking off a
    // viewDidLoad, which caused us to be able to fall through this check twice.
    //
    //The fix is to grab the bounds, and then check again that the child container view has
    //not been created.
    
    CGRect centerFrame = self.childControllerContainerView.bounds;
    if(_centerContainerView == nil){
        _centerContainerView = [[DrawerCenterContainerView alloc] initWithFrame:centerFrame];
        [self.centerContainerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.centerContainerView setBackgroundColor:[UIColor clearColor]];
        [self.centerContainerView setOpenSide:self.openSide];
        [self.centerContainerView setCenterInteractionMode:self.centerHiddenInteractionMode];
        [self.childControllerContainerView addSubview:self.centerContainerView];
    }
  }
  
    UIViewController * oldCenterViewController = self.centerViewController;
    if(oldCenterViewController){
        [oldCenterViewController willMoveToParentViewController:nil];
        if(animated == NO){
            [oldCenterViewController beginAppearanceTransition:NO animated:NO];
        }
        [oldCenterViewController.view removeFromSuperview];
        if(animated == NO){
            [oldCenterViewController endAppearanceTransition];
        }
        [oldCenterViewController removeFromParentViewController];
    }
    
    _centerViewController = centerViewController;
    
    [self addChildViewController:self.centerViewController];
    [self.centerViewController.view setFrame:self.childControllerContainerView.bounds];
    [self.centerContainerView addSubview:self.centerViewController.view];
    [self.childControllerContainerView bringSubviewToFront:self.centerContainerView];
    [self.centerViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self updateShadowForCenterView];
    
    if(animated == NO){
        // If drawer is offscreen, then viewWillAppear: will take care of this
        if(self.view.window) {
            [self.centerViewController beginAppearanceTransition:YES animated:NO];
            [self.centerViewController endAppearanceTransition];
        }
        [self.centerViewController didMoveToParentViewController:self];
    }
}

- (void)setCenterViewController:(UIViewController *)newCenterViewController withCloseAnimation:(BOOL)animated completion:(void(^)(BOOL finished))completion{
    
    if(self.openSide == DrawerMenuSideNone){
        //If a side drawer isn't open, there is nothing to animate...
        animated = NO;
    }
  
    BOOL forwardAppearanceMethodsToCenterViewController = ([self.centerViewController isEqual:newCenterViewController] == NO);

    UIViewController * oldCenterViewController = self.centerViewController;
    // This is related to issue 363 (https://github.com/novkostya/UIGeneralDrawerMenuController/pull/363)
    // This needs to be refactored so the appearance logic is easier
    // to follow across the multiple close/setter methods
    if (animated && forwardAppearanceMethodsToCenterViewController) {
        [oldCenterViewController beginAppearanceTransition:NO animated:NO];
    }
    
    [self setCenterViewController:newCenterViewController animated:animated];
    
    // Related to note above.
    if (animated && forwardAppearanceMethodsToCenterViewController) {
        [oldCenterViewController endAppearanceTransition];
    }
    
    if(animated){
        [self updateDrawerVisualStateForDrawerSide:self.openSide percentVisible:1.0];
        if (forwardAppearanceMethodsToCenterViewController) {
            [self.centerViewController beginAppearanceTransition:YES animated:animated];
        }
        [self
         closeDrawerAnimated:animated
         completion:^(BOOL finished) {
             if (forwardAppearanceMethodsToCenterViewController) {
                 [self.centerViewController endAppearanceTransition];
                 [self.centerViewController didMoveToParentViewController:self];
             }
             if(completion){
                 completion(finished);
             }
         }];
    }
    else {
        if(completion) {
            completion(YES);
        }
    }
}

- (void)setCenterViewController:(UIViewController *)newCenterViewController withFullCloseAnimation:(BOOL)animated completion:(void(^)(BOOL finished))completion{
    if(self.openSide != DrawerMenuSideNone &&
       animated){
        
        BOOL forwardAppearanceMethodsToCenterViewController = ([self.centerViewController isEqual:newCenterViewController] == NO);
        
        UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:self.openSide];
        
        CGFloat targetClosePoint = 0.0f;
        if(self.openSide == DrawerMenuSideRight){
            targetClosePoint = -CGRectGetWidth(self.childControllerContainerView.bounds);
        }
        else if(self.openSide == DrawerMenuSideLeft) {
            targetClosePoint = CGRectGetWidth(self.childControllerContainerView.bounds);
        }
        
        CGFloat distance = ABS(self.centerContainerView.frame.origin.x-targetClosePoint);
        NSTimeInterval firstDuration = [self animationDurationForAnimationDistance:distance];
        
        CGRect newCenterRect = self.centerContainerView.frame;
        
        [self setAnimatingDrawer:animated];
        
        UIViewController * oldCenterViewController = self.centerViewController;
        if(forwardAppearanceMethodsToCenterViewController ){
            [oldCenterViewController beginAppearanceTransition:NO animated:animated];
        }
        newCenterRect.origin.x = targetClosePoint;
        [UIView
         animateWithDuration:firstDuration
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             [self.centerContainerView setFrame:newCenterRect];
             [sideDrawerViewController.view setFrame:self.childControllerContainerView.bounds];
         }
         completion:^(BOOL finished) {

             CGRect oldCenterRect = self.centerContainerView.frame;
             [self setCenterViewController:newCenterViewController animated:animated];
             [self.centerContainerView setFrame:oldCenterRect];
             [self updateDrawerVisualStateForDrawerSide:self.openSide percentVisible:1.0];
             if(forwardAppearanceMethodsToCenterViewController) {
                 [oldCenterViewController endAppearanceTransition];
                 [self.centerViewController beginAppearanceTransition:YES animated:animated];
             }
             [sideDrawerViewController beginAppearanceTransition:NO animated:animated];
            [UIView
             animateWithDuration:[self animationDurationForAnimationDistance:CGRectGetWidth(self.childControllerContainerView.bounds)]
             delay:DrawerMenuDefaultFullAnimationDelay
             options:UIViewAnimationOptionCurveEaseInOut
             animations:^{
                 [self.centerContainerView setFrame:self.childControllerContainerView.bounds];
                 [self updateDrawerVisualStateForDrawerSide:self.openSide percentVisible:0.0];
             }
             completion:^(BOOL finished) {
                 if (forwardAppearanceMethodsToCenterViewController) {
                     [self.centerViewController endAppearanceTransition];
                     [self.centerViewController didMoveToParentViewController:self];
                 }
                 [sideDrawerViewController endAppearanceTransition];
                 [self resetDrawerVisualStateForDrawerSide:self.openSide];

                 [sideDrawerViewController.view setFrame:sideDrawerViewController.visibleDrawerFrame];
                 
                 [self setOpenSide:DrawerMenuSideNone];
                 [self setAnimatingDrawer:NO];
                 if(completion){
                     completion(finished);
                 }
             }];
         }];
    }
    else {
        [self setCenterViewController:newCenterViewController animated:animated];
        if(self.openSide != DrawerMenuSideNone){
            [self closeDrawerAnimated:animated completion:completion];
        }
        else if(completion){
            completion(YES);
        }
    }
}

#pragma mark - Size Methods
- (void)setMaximumLeftDrawerWidth:(CGFloat)width animated:(BOOL)animated completion:(void(^)(BOOL finished))completion{
    [self setMaximumDrawerWidth:width forSide:DrawerMenuSideLeft animated:animated completion:completion];
}

- (void)setMaximumRightDrawerWidth:(CGFloat)width animated:(BOOL)animated completion:(void(^)(BOOL finished))completion{
    [self setMaximumDrawerWidth:width forSide:DrawerMenuSideRight animated:animated completion:completion];
}

- (void)setMaximumDrawerWidth:(CGFloat)width forSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated completion:(void(^)(BOOL finished))completion{
    NSParameterAssert(width > 0);
    NSParameterAssert(drawerSide != DrawerMenuSideNone);
    
    UIViewController *sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
    CGFloat oldWidth = 0.f;
    NSInteger drawerSideOriginCorrection = 1;
    if (drawerSide == DrawerMenuSideLeft) {
        oldWidth = _maximumLeftDrawerWidth;
        _maximumLeftDrawerWidth = width;
    }
    else if(drawerSide == DrawerMenuSideRight){
        oldWidth = _maximumRightDrawerWidth;
        _maximumRightDrawerWidth = width;
        drawerSideOriginCorrection = -1;
    }
    
    CGFloat distance = ABS(width-oldWidth);
    NSTimeInterval duration = [self animationDurationForAnimationDistance:distance];
    
    if(self.openSide == drawerSide){
        CGRect newCenterRect = self.centerContainerView.frame;
        newCenterRect.origin.x =  drawerSideOriginCorrection*width;
        [UIView
         animateWithDuration:(animated?duration:0)
         delay:0.0
         options:UIViewAnimationOptionCurveEaseInOut
         animations:^{
             [self.centerContainerView setFrame:newCenterRect];
             [sideDrawerViewController.view setFrame:sideDrawerViewController.visibleDrawerFrame];
         }
         completion:^(BOOL finished) {
             if(completion != nil){
                 completion(finished);
             }
         }];
    }
    else{
        [sideDrawerViewController.view setFrame:sideDrawerViewController.visibleDrawerFrame];
        if(completion != nil){
            completion(YES);
        }
    }
}

#pragma mark - Bounce Methods
- (void)bouncePreviewForDrawerSide:(DrawerMenuSide)drawerSide completion:(void(^)(BOOL finished))completion{
    NSParameterAssert(drawerSide!=DrawerMenuSideNone);
    [self bouncePreviewForDrawerSide:drawerSide distance:DrawerMenuDefaultBounceDistance completion:completion];
}

- (void)bouncePreviewForDrawerSide:(DrawerMenuSide)drawerSide distance:(CGFloat)distance completion:(void(^)(BOOL finished))completion{
    NSParameterAssert(drawerSide!=DrawerMenuSideNone);
    
    UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
    
    if(sideDrawerViewController == nil ||
       self.openSide != DrawerMenuSideNone){
        if(completion){
            completion(NO);
        }
        return;
    }
    else {
        [self prepareToPresentDrawer:drawerSide animated:YES];
        
        [self updateDrawerVisualStateForDrawerSide:drawerSide percentVisible:1.0];
        
        [CATransaction begin];
        [CATransaction
         setCompletionBlock:^{
             [sideDrawerViewController endAppearanceTransition];
             [sideDrawerViewController beginAppearanceTransition:NO animated:NO];
             [sideDrawerViewController endAppearanceTransition];
             if(completion){
                 completion(YES);
             }
         }];
        
        CGFloat modifier = ((drawerSide == DrawerMenuSideLeft)?1.0:-1.0);
        CAKeyframeAnimation *animation = bounceKeyFrameAnimationForDistanceOnView(distance*modifier,self.centerContainerView);
        [self.centerContainerView.layer addAnimation:animation forKey:@"bouncing"];
        
        [CATransaction commit];
    }
}

#pragma mark - Setting Drawer Visual State
- (void)setDrawerVisualStateBlock:(void (^)(UIGeneralDrawerMenuController *, DrawerMenuSide, CGFloat))drawerVisualStateBlock{
    [self setDrawerVisualState:drawerVisualStateBlock];
}

#pragma mark - Setting Custom Gesture Handler Block
- (void)setGestureShouldRecognizeTouchBlock:(BOOL (^)(UIGeneralDrawerMenuController *, UIGestureRecognizer *, UITouch *))gestureShouldRecognizeTouchBlock{
    [self setGestureShouldRecognizeTouch:gestureShouldRecognizeTouchBlock];
}

#pragma mark - Setting the Gesture Completion Block
- (void)setGestureCompletionBlock:(void (^)(UIGeneralDrawerMenuController *, UIGestureRecognizer *))gestureCompletionBlock{
    [self setGestureCompletion:gestureCompletionBlock];
}

#pragma mark - Subclass Methods
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods{
    return NO;
}

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers{
    return NO;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
	[self setupGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.centerViewController beginAppearanceTransition:YES animated:animated];
    
    if(self.openSide == DrawerMenuSideLeft) {
        [self.leftDrawerViewController beginAppearanceTransition:YES animated:animated];
    }
    else if(self.openSide == DrawerMenuSideRight) {
        [self.rightDrawerViewController beginAppearanceTransition:YES animated:animated];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateShadowForCenterView];
    [self.centerViewController endAppearanceTransition];
    
    if(self.openSide == DrawerMenuSideLeft) {
        [self.leftDrawerViewController endAppearanceTransition];
    }
    else if(self.openSide == DrawerMenuSideRight) {
        [self.rightDrawerViewController endAppearanceTransition];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.centerViewController beginAppearanceTransition:NO animated:animated];
    if(self.openSide == DrawerMenuSideLeft) {
        [self.leftDrawerViewController beginAppearanceTransition:NO animated:animated];
    }
    else if (self.openSide == DrawerMenuSideRight) {
        [self.rightDrawerViewController beginAppearanceTransition:NO animated:animated];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.centerViewController endAppearanceTransition];
    if(self.openSide == DrawerMenuSideLeft) {
        [self.leftDrawerViewController endAppearanceTransition];
    }
    else if (self.openSide == DrawerMenuSideRight) {
        [self.rightDrawerViewController endAppearanceTransition];
    }
}

#pragma mark Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    //If a rotation begins, we are going to cancel the current gesture and reset transform and anchor points so everything works correctly
    BOOL gestureInProgress = NO;
    for(UIGestureRecognizer * gesture in self.view.gestureRecognizers){
        if(gesture.state == UIGestureRecognizerStateChanged){
            [gesture setEnabled:NO];
            [gesture setEnabled:YES];
            gestureInProgress = YES;
        }
        if (gestureInProgress) {
            [self resetDrawerVisualStateForDrawerSide:self.openSide];
        }
    }
    if ([self needsManualForwardingOfRotationEvents]){
        for(UIViewController * childViewController in self.childViewControllers){
            [childViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
        }
    }
    
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    //We need to support the shadow path rotation animation
    //Inspired from here: http://blog.radi.ws/post/8348898129/calayers-shadowpath-and-uiview-autoresizing
    if(self.showsShadow){
        CGPathRef oldShadowPath = self.centerContainerView.layer.shadowPath;
        if(oldShadowPath){
            CFRetain(oldShadowPath);
        }
        
        [self updateShadowForCenterView];
        
        if (oldShadowPath) {
            [self.centerContainerView.layer addAnimation:((^ {
                CABasicAnimation *transition = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
                transition.fromValue = (__bridge id)oldShadowPath;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                transition.duration = duration;
                return transition;
            })()) forKey:@"transition"];
            CFRelease(oldShadowPath);
        }
    }
    
    if ([self needsManualForwardingOfRotationEvents]){
        for(UIViewController * childViewController in self.childViewControllers){
            [childViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
        }
    }
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if ([self needsManualForwardingOfRotationEvents]){
        for(UIViewController * childViewController in self.childViewControllers){
            [childViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
        }
    }
}

#pragma mark - Setters
- (void)setRightDrawerViewController:(UIViewController *)rightDrawerViewController{
    [self setDrawerViewController:rightDrawerViewController forSide:DrawerMenuSideRight];
}

- (void)setLeftDrawerViewController:(UIViewController *)leftDrawerViewController{
    [self setDrawerViewController:leftDrawerViewController forSide:DrawerMenuSideLeft];
}

- (void)setDrawerViewController:(UIViewController *)viewController forSide:(DrawerMenuSide)drawerSide{
    NSParameterAssert(drawerSide != DrawerMenuSideNone);
    
    UIViewController *currentSideViewController = [self sideDrawerViewControllerForSide:drawerSide];

    if (currentSideViewController == viewController) {
        return;
    }

    if (currentSideViewController != nil) {
        [currentSideViewController beginAppearanceTransition:NO animated:NO];
        [currentSideViewController.view removeFromSuperview];
        [currentSideViewController endAppearanceTransition];
        [currentSideViewController willMoveToParentViewController:nil];
        [currentSideViewController removeFromParentViewController];
    }
    
    UIViewAutoresizing autoResizingMask = 0;
    if (drawerSide == DrawerMenuSideLeft) {
        _leftDrawerViewController = viewController;
        autoResizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        
    }
    else if(drawerSide == DrawerMenuSideRight){
        _rightDrawerViewController = viewController;
        autoResizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    }
    
    if(viewController){
        [self addChildViewController:viewController];
        
        if((self.openSide == drawerSide) &&
           [self.childControllerContainerView.subviews containsObject:self.centerContainerView]){
            [self.childControllerContainerView insertSubview:viewController.view belowSubview:self.centerContainerView];
            [viewController beginAppearanceTransition:YES animated:NO];
            [viewController endAppearanceTransition];
        }
        else{
            [self.childControllerContainerView addSubview:viewController.view];
            [self.childControllerContainerView sendSubviewToBack:viewController.view];
            [viewController.view setHidden:YES];
        }
        [viewController didMoveToParentViewController:self];
        [viewController.view setAutoresizingMask:autoResizingMask];
        [viewController.view setFrame:viewController.visibleDrawerFrame];
    }
}

- (void)setCenterViewController:(UIViewController *)centerViewController{
    [self setCenterViewController:centerViewController animated:NO];
}

- (void)setShowsShadow:(BOOL)showsShadow{
    _showsShadow = showsShadow;
    [self updateShadowForCenterView];
}

- (void)setShadowRadius:(CGFloat)shadowRadius{
    _shadowRadius = shadowRadius;
    [self updateShadowForCenterView];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    _shadowOpacity = shadowOpacity;
    [self updateShadowForCenterView];
}

- (void)setShadowOffset:(CGSize)shadowOffset{
    _shadowOffset = shadowOffset;
    [self updateShadowForCenterView];
}

- (void)setShadowColor:(UIColor *)shadowColor{
    _shadowColor = shadowColor;
    [self updateShadowForCenterView];
}

- (void)setOpenSide:(DrawerMenuSide)openSide{
    if(_openSide != openSide){
        _openSide = openSide;
        [self.centerContainerView setOpenSide:openSide];
        if(openSide == DrawerMenuSideNone){
            [self.leftDrawerViewController.view setHidden:YES];
            [self.rightDrawerViewController.view setHidden:YES];
        }
        [self setNeedsStatusBarAppearanceUpdateIfSupported];
    }
}

- (void)setCenterHiddenInteractionMode:(DrawerOpenCenterInteractionMode)centerHiddenInteractionMode{
    if(_centerHiddenInteractionMode!=centerHiddenInteractionMode){
        _centerHiddenInteractionMode = centerHiddenInteractionMode;
        [self.centerContainerView setCenterInteractionMode:centerHiddenInteractionMode];
    }
}

- (void)setMaximumLeftDrawerWidth:(CGFloat)maximumLeftDrawerWidth{
    [self setMaximumLeftDrawerWidth:maximumLeftDrawerWidth animated:NO completion:nil];
}

- (void)setMaximumRightDrawerWidth:(CGFloat)maximumRightDrawerWidth{
    [self setMaximumRightDrawerWidth:maximumRightDrawerWidth animated:NO completion:nil];
}

- (void)setShowsStatusBarBackgroundView:(BOOL)showsDummyStatusBar{
    if(showsDummyStatusBar!=_showsStatusBarBackgroundView){
        _showsStatusBarBackgroundView = showsDummyStatusBar;
        CGRect frame = self.childControllerContainerView.frame;
        if(_showsStatusBarBackgroundView){
            frame.origin.y = 20;
            frame.size.height = CGRectGetHeight(self.view.bounds)-20;
        }
        else {
            frame.origin.y = 0;
            frame.size.height = CGRectGetHeight(self.view.bounds);
        }
        [self.childControllerContainerView setFrame:frame];
        [self.dummyStatusBarView setHidden:!showsDummyStatusBar];
    }
}

- (void)setStatusBarViewBackgroundColor:(UIColor *)dummyStatusBarColor{
    _statusBarViewBackgroundColor = dummyStatusBarColor;
    [self.dummyStatusBarView setBackgroundColor:_statusBarViewBackgroundColor];
}

- (void)setAnimatingDrawer:(BOOL)animatingDrawer{
    _animatingDrawer = animatingDrawer;
    [self.view setUserInteractionEnabled:!animatingDrawer];
}

#pragma mark - Getters
- (CGFloat)maximumLeftDrawerWidth{
    if(self.leftDrawerViewController){
        return _maximumLeftDrawerWidth;
    }
    else{
        return 0;
    }
}

- (CGFloat)maximumRightDrawerWidth{
    if(self.rightDrawerViewController){
        return _maximumRightDrawerWidth;
    }
    else {
        return 0;
    }
}

- (CGFloat)visibleLeftDrawerWidth{
    return MAX(0.0,CGRectGetMinX(self.centerContainerView.frame));
}

- (CGFloat)visibleRightDrawerWidth{
    if(CGRectGetMinX(self.centerContainerView.frame)<0){
        return CGRectGetWidth(self.childControllerContainerView.bounds)-CGRectGetMaxX(self.centerContainerView.frame);
    }
    else {
        return 0.0f;
    }
}

- (UIView*)childControllerContainerView{
    if(_childControllerContainerView == nil){
        //Issue #152 (https://github.com/mutualmobile/UIGeneralDrawerMenuController/issues/152)
        //Turns out we have two child container views getting added to the view during init,
        //because the first request self.view.bounds was kicking off a viewDidLoad, which
        //caused us to be able to fall through this check twice.
        //
        //The fix is to grab the bounds, and then check again that the child container view has
        //not been created.
        CGRect childContainerViewFrame = self.view.bounds;
        if(_childControllerContainerView == nil){
            _childControllerContainerView = [[UIView alloc] initWithFrame:childContainerViewFrame];
            [_childControllerContainerView setBackgroundColor:[UIColor clearColor]];
            [_childControllerContainerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
            [self.view addSubview:_childControllerContainerView];
        }

    }
    return _childControllerContainerView;
}

- (UIView*)dummyStatusBarView{
    if(_dummyStatusBarView==nil){
        _dummyStatusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 20)];
        [_dummyStatusBarView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [_dummyStatusBarView setBackgroundColor:self.statusBarViewBackgroundColor];
        [_dummyStatusBarView setHidden:!_showsStatusBarBackgroundView];
        [self.view addSubview:_dummyStatusBarView];
    }
    return _dummyStatusBarView;
}

- (UIColor*)statusBarViewBackgroundColor{
    if(_statusBarViewBackgroundColor == nil){
        _statusBarViewBackgroundColor = [UIColor blackColor];
    }
    return _statusBarViewBackgroundColor;
}

#pragma mark - Gesture Handlers

- (void)tapGestureCallback:(UITapGestureRecognizer *)tapGesture{
    if(self.openSide != DrawerMenuSideNone &&
       self.isAnimatingDrawer == NO){
        [self closeDrawerAnimated:YES completion:^(BOOL finished) {
            if(self.gestureCompletion){
                self.gestureCompletion(self, tapGesture);
            }
        }];
    }
}

- (void)panGestureCallback:(UIPanGestureRecognizer *)panGesture{
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            if(self.animatingDrawer){
                [panGesture setEnabled:NO];
                break;
            }
            else {
                self.startingPanRect = self.centerContainerView.frame;
            }
        }
        case UIGestureRecognizerStateChanged:{
            self.view.userInteractionEnabled = NO;
            CGRect newFrame = self.startingPanRect;
            CGPoint translatedPoint = [panGesture translationInView:self.centerContainerView];
            newFrame.origin.x = [self roundedOriginXForDrawerConstriants:CGRectGetMinX(self.startingPanRect)+translatedPoint.x];
            newFrame = CGRectIntegral(newFrame);
            CGFloat xOffset = newFrame.origin.x;
            
            DrawerMenuSide visibleSide = DrawerMenuSideNone;
            CGFloat percentVisible = 0.0;
            if(xOffset > 0){
                visibleSide = DrawerMenuSideLeft;
                percentVisible = xOffset/self.maximumLeftDrawerWidth;
            }
            else if(xOffset < 0){
                visibleSide = DrawerMenuSideRight;
                percentVisible = ABS(xOffset)/self.maximumRightDrawerWidth;
            }
            UIViewController * visibleSideDrawerViewController = [self sideDrawerViewControllerForSide:visibleSide];
            
            if(self.openSide != visibleSide){
                //Handle disappearing the visible drawer
                UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:self.openSide];
                [sideDrawerViewController beginAppearanceTransition:NO animated:NO];
                [sideDrawerViewController endAppearanceTransition];

                //Drawer is about to become visible
                [self prepareToPresentDrawer:visibleSide animated:NO];
                [visibleSideDrawerViewController endAppearanceTransition];
                [self setOpenSide:visibleSide];
            }
            else if(visibleSide == DrawerMenuSideNone){
                [self setOpenSide:DrawerMenuSideNone];
            }
            
            [self updateDrawerVisualStateForDrawerSide:visibleSide percentVisible:percentVisible];
            
            [self.centerContainerView setCenter:CGPointMake(CGRectGetMidX(newFrame), CGRectGetMidY(newFrame))];
            
            newFrame = self.centerContainerView.frame;
            newFrame.origin.x = floor(newFrame.origin.x);
            newFrame.origin.y = floor(newFrame.origin.y);
            self.centerContainerView.frame = newFrame;
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            self.startingPanRect = CGRectNull;
            CGPoint velocity = [panGesture velocityInView:self.childControllerContainerView];
            [self finishAnimationForPanGestureWithXVelocity:velocity.x completion:^(BOOL finished) {
                if(self.gestureCompletion){
                    self.gestureCompletion(self, panGesture);
                }
            }];
            self.view.userInteractionEnabled = YES;
            break;
        }
        default:
            break;
    }
}

#pragma mark - iOS 7 Status Bar Helpers
- (UIViewController*)childViewControllerForStatusBarStyle{
    return [self childViewControllerForSide:self.openSide];
}

- (UIViewController*)childViewControllerForStatusBarHidden{
    return [self childViewControllerForSide:self.openSide];
}

- (void)setNeedsStatusBarAppearanceUpdateIfSupported{
    if([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]){
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

#pragma mark - iOS 8 Rotation Helpers
- (BOOL)needsManualForwardingOfRotationEvents{
    BOOL isIOS8 = (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1);
    return !isIOS8;
}

#pragma mark - Animation helpers
- (void)finishAnimationForPanGestureWithXVelocity:(CGFloat)xVelocity completion:(void(^)(BOOL finished))completion{
    CGFloat currentOriginX = CGRectGetMinX(self.centerContainerView.frame);
    
    CGFloat animationVelocity = MAX(ABS(xVelocity),self.panVelocityXAnimationThreshold*2);
    
    if(self.openSide == DrawerMenuSideLeft) {
        CGFloat midPoint = self.maximumLeftDrawerWidth / 2.0;
        if(xVelocity > self.panVelocityXAnimationThreshold){
            [self openDrawerSide:DrawerMenuSideLeft animated:YES velocity:animationVelocity animationOptions:UIViewAnimationOptionCurveEaseOut completion:completion];
        }
        else if(xVelocity < -self.panVelocityXAnimationThreshold){
            [self closeDrawerAnimated:YES velocity:animationVelocity animationOptions:UIViewAnimationOptionCurveEaseOut completion:completion];
        }
        else if(currentOriginX < midPoint){
            [self closeDrawerAnimated:YES completion:completion];
        }
        else {
            [self openDrawerSide:DrawerMenuSideLeft animated:YES completion:completion];
        }
    }
    else if(self.openSide == DrawerMenuSideRight){
        currentOriginX = CGRectGetMaxX(self.centerContainerView.frame);
        CGFloat midPoint = (CGRectGetWidth(self.childControllerContainerView.bounds)-self.maximumRightDrawerWidth) + (self.maximumRightDrawerWidth / 2.0);
        if(xVelocity > self.panVelocityXAnimationThreshold){
            [self closeDrawerAnimated:YES velocity:animationVelocity animationOptions:UIViewAnimationOptionCurveEaseOut completion:completion];
        }
        else if (xVelocity < -self.panVelocityXAnimationThreshold){
            [self openDrawerSide:DrawerMenuSideRight animated:YES velocity:animationVelocity animationOptions:UIViewAnimationOptionCurveEaseOut completion:completion];
        }
        else if(currentOriginX > midPoint){
            [self closeDrawerAnimated:YES completion:completion];
        }
        else {
            [self openDrawerSide:DrawerMenuSideRight animated:YES completion:completion];
        }
    }
    else {
        if(completion){
            completion(NO);
        }
    }
}

- (void)updateDrawerVisualStateForDrawerSide:(DrawerMenuSide)drawerSide percentVisible:(CGFloat)percentVisible{
    if(self.drawerVisualState){
        self.drawerVisualState(self,drawerSide,percentVisible);
    }
    else if(self.shouldStretchDrawer){
        [self applyOvershootScaleTransformForDrawerSide:drawerSide percentVisible:percentVisible];
    }
}

- (void)applyOvershootScaleTransformForDrawerSide:(DrawerMenuSide)drawerSide percentVisible:(CGFloat)percentVisible{
    
    if (percentVisible >= 1.f) {
        CATransform3D transform = CATransform3DIdentity;
        UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
        if(drawerSide == DrawerMenuSideLeft) {
            transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
            transform = CATransform3DTranslate(transform, self.maximumLeftDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
        }
        else if(drawerSide == DrawerMenuSideRight){
            transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
            transform = CATransform3DTranslate(transform, -self.maximumRightDrawerWidth*(percentVisible-1.f)/2, 0.f, 0.f);
        }
        sideDrawerViewController.view.layer.transform = transform;
    }
}

- (void)resetDrawerVisualStateForDrawerSide:(DrawerMenuSide)drawerSide{
    UIViewController * sideDrawerViewController = [self sideDrawerViewControllerForSide:drawerSide];
    
    [sideDrawerViewController.view.layer setAnchorPoint:CGPointMake(0.5f, 0.5f)];
    [sideDrawerViewController.view.layer setTransform:CATransform3DIdentity];
    [sideDrawerViewController.view setAlpha:1.0];
}

- (CGFloat)roundedOriginXForDrawerConstriants:(CGFloat)originX{
    
    if (originX < -self.maximumRightDrawerWidth) {
        if (self.shouldStretchDrawer &&
            self.rightDrawerViewController) {
            CGFloat maxOvershoot = (CGRectGetWidth(self.centerContainerView.frame)-self.maximumRightDrawerWidth)*DrawerMenuOvershootPercentage;
            return originXForDrawerOriginAndTargetOriginOffset(originX, -self.maximumRightDrawerWidth, maxOvershoot);
        }
        else{
            return -self.maximumRightDrawerWidth;
        }
    }
    else if(originX > self.maximumLeftDrawerWidth){
        if (self.shouldStretchDrawer &&
            self.leftDrawerViewController) {
            CGFloat maxOvershoot = (CGRectGetWidth(self.centerContainerView.frame)-self.maximumLeftDrawerWidth)*DrawerMenuOvershootPercentage;
            return originXForDrawerOriginAndTargetOriginOffset(originX, self.maximumLeftDrawerWidth, maxOvershoot);
        }
        else{
            return self.maximumLeftDrawerWidth;
        }
    }
    
    return originX;
}

static inline CGFloat originXForDrawerOriginAndTargetOriginOffset(CGFloat originX, CGFloat targetOffset, CGFloat maxOvershoot){
    CGFloat delta = ABS(originX - targetOffset);
    CGFloat maxLinearPercentage = DrawerMenuOvershootLinearRangePercentage;
    CGFloat nonLinearRange = maxOvershoot * maxLinearPercentage;
    CGFloat nonLinearScalingDelta = (delta - nonLinearRange);
    CGFloat overshoot = nonLinearRange + nonLinearScalingDelta * nonLinearRange/sqrt(pow(nonLinearScalingDelta,2.f) + 15000);
    
    if (delta < nonLinearRange) {
        return originX;
    }
    else if (targetOffset < 0) {
        return targetOffset - round(overshoot);
    }
    else{
        return targetOffset + round(overshoot);
    }
}

#pragma mark - Helpers
- (void)setupGestureRecognizers{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureCallback:)];
    [pan setDelegate:self];
    [self.view addGestureRecognizer:pan];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCallback:)];
    [tap setDelegate:self];
    [self.view addGestureRecognizer:tap];
}

- (void)prepareToPresentDrawer:(DrawerMenuSide)drawer animated:(BOOL)animated{
    DrawerMenuSide drawerToHide = DrawerMenuSideNone;
    if(drawer == DrawerMenuSideLeft){
        drawerToHide = DrawerMenuSideRight;
    }
    else if(drawer == DrawerMenuSideRight){
        drawerToHide = DrawerMenuSideLeft;
    }
    
    UIViewController * sideDrawerViewControllerToPresent = [self sideDrawerViewControllerForSide:drawer];
    UIViewController * sideDrawerViewControllerToHide = [self sideDrawerViewControllerForSide:drawerToHide];

    [self.childControllerContainerView sendSubviewToBack:sideDrawerViewControllerToHide.view];
    [sideDrawerViewControllerToHide.view setHidden:YES];
    [sideDrawerViewControllerToPresent.view setHidden:NO];
    [self resetDrawerVisualStateForDrawerSide:drawer];
    [sideDrawerViewControllerToPresent.view setFrame:sideDrawerViewControllerToPresent.visibleDrawerFrame];
    [self updateDrawerVisualStateForDrawerSide:drawer percentVisible:0.0];
    [sideDrawerViewControllerToPresent beginAppearanceTransition:YES animated:animated];
}

- (void)updateShadowForCenterView{
    UIView * centerView = self.centerContainerView;
    if(self.showsShadow){
        centerView.layer.masksToBounds = NO;
        centerView.layer.shadowRadius = self.shadowRadius;
        centerView.layer.shadowOpacity = self.shadowOpacity;
        centerView.layer.shadowOffset = self.shadowOffset;
        centerView.layer.shadowColor = [self.shadowColor CGColor];
        
        /** In the event this gets called a lot, we won't update the shadowPath
        unless it needs to be updated (like during rotation) */
        if (centerView.layer.shadowPath == NULL) {
            centerView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.centerContainerView.bounds] CGPath];
        }
        else{
            CGRect currentPath = CGPathGetPathBoundingBox(centerView.layer.shadowPath);
            if (CGRectEqualToRect(currentPath, centerView.bounds) == NO){
                centerView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.centerContainerView.bounds] CGPath];
            }
        }
    }
    else if (centerView.layer.shadowPath != NULL) {
        centerView.layer.shadowRadius = 0.f;
        centerView.layer.shadowOpacity = 0.f;
        centerView.layer.shadowOffset = CGSizeMake(0, -3);
        centerView.layer.shadowPath = NULL;
        centerView.layer.masksToBounds = YES;
    }
}

- (NSTimeInterval)animationDurationForAnimationDistance:(CGFloat)distance{
    NSTimeInterval duration = MAX(distance/self.animationVelocity,DrawerMenuMinimumAnimationDuration);
    return duration;
}

- (UIViewController*)sideDrawerViewControllerForSide:(DrawerMenuSide)drawerSide{
    UIViewController * sideDrawerViewController = nil;
    if(drawerSide != DrawerMenuSideNone){
        sideDrawerViewController = [self childViewControllerForSide:drawerSide];
    }
    return sideDrawerViewController;
}

- (UIViewController*)childViewControllerForSide:(DrawerMenuSide)drawerSide{
    UIViewController * childViewController = nil;
    switch (drawerSide) {
        case DrawerMenuSideLeft:
            childViewController = self.leftDrawerViewController;
            break;
        case DrawerMenuSideRight:
            childViewController = self.rightDrawerViewController;
            break;
        case DrawerMenuSideNone:
            childViewController = self.centerViewController;
            break;
    }
    return childViewController;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if(self.openSide == DrawerMenuSideNone){
        OpenDrawerGestureMode possibleOpenGestureModes = [self possibleOpenGestureModesForGestureRecognizer:gestureRecognizer
                                                                                                    withTouch:touch];
        return ((self.openDrawerGestureModeMask & possibleOpenGestureModes)>0);
    }
    else{
        CloseDrawerGestureMode possibleCloseGestureModes = [self possibleCloseGestureModesForGestureRecognizer:gestureRecognizer
                                                                                                       withTouch:touch];
        return ((self.closeDrawerGestureModeMask & possibleCloseGestureModes)>0);
    }
}

#pragma mark Gesture Recogizner Delegate Helpers
- (CloseDrawerGestureMode)possibleCloseGestureModesForGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer withTouch:(UITouch*)touch{
    CGPoint point = [touch locationInView:self.childControllerContainerView];
    CloseDrawerGestureMode possibleCloseGestureModes = CloseDrawerGestureModeNone;
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
        if([self isPointContainedWithinNavigationRect:point]){
            possibleCloseGestureModes |= CloseDrawerGestureModeTapNavigationBar;
        }
        if([self isPointContainedWithinCenterViewContentRect:point]){
            possibleCloseGestureModes |= CloseDrawerGestureModeTapCenterView;
        }
    }
    else if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        if([self isPointContainedWithinNavigationRect:point]){
            possibleCloseGestureModes |= CloseDrawerGestureModePanningNavigationBar;
        }
        if([self isPointContainedWithinCenterViewContentRect:point]){
            possibleCloseGestureModes |= CloseDrawerGestureModePanningCenterView;
        }
        if([self isPointContainedWithinRightBezelRect:point] &&
           self.openSide == DrawerMenuSideLeft){
            possibleCloseGestureModes |= CloseDrawerGestureModeBezelPanningCenterView;
        }
        if([self isPointContainedWithinLeftBezelRect:point] &&
           self.openSide == DrawerMenuSideRight){
            possibleCloseGestureModes |= CloseDrawerGestureModeBezelPanningCenterView;
        }
        if([self isPointContainedWithinCenterViewContentRect:point] == NO &&
           [self isPointContainedWithinNavigationRect:point] == NO){
            possibleCloseGestureModes |= CloseDrawerGestureModePanningDrawerView;
        }
    }
    if((self.closeDrawerGestureModeMask & CloseDrawerGestureModeCustom) > 0 &&
       self.gestureShouldRecognizeTouch){
        if(self.gestureShouldRecognizeTouch(self,gestureRecognizer,touch)){
            possibleCloseGestureModes |= CloseDrawerGestureModeCustom;
        }
    }
    return possibleCloseGestureModes;
}

- (OpenDrawerGestureMode)possibleOpenGestureModesForGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer withTouch:(UITouch*)touch{
    CGPoint point = [touch locationInView:self.childControllerContainerView];
    OpenDrawerGestureMode possibleOpenGestureModes = OpenDrawerGestureModeNone;
    if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
        if([self isPointContainedWithinNavigationRect:point]){
            possibleOpenGestureModes |= OpenDrawerGestureModePanningNavigationBar;
        }
        if([self isPointContainedWithinCenterViewContentRect:point]){
            possibleOpenGestureModes |= OpenDrawerGestureModePanningCenterView;
        }
        if([self isPointContainedWithinLeftBezelRect:point] &&
           self.leftDrawerViewController){
            possibleOpenGestureModes |= OpenDrawerGestureModeBezelPanningCenterView;
        }
        if([self isPointContainedWithinRightBezelRect:point] &&
           self.rightDrawerViewController){
            possibleOpenGestureModes |= OpenDrawerGestureModeBezelPanningCenterView;
        }
    }
    if((self.openDrawerGestureModeMask & OpenDrawerGestureModeCustom) > 0 &&
       self.gestureShouldRecognizeTouch){
        if(self.gestureShouldRecognizeTouch(self,gestureRecognizer,touch)){
            possibleOpenGestureModes |= OpenDrawerGestureModeCustom;
        }
    }
    return possibleOpenGestureModes;
}

- (BOOL)isPointContainedWithinNavigationRect:(CGPoint)point{
    CGRect navigationBarRect = CGRectNull;
    if([self.centerViewController isKindOfClass:[UINavigationController class]]){
        UINavigationBar * navBar = [(UINavigationController*)self.centerViewController navigationBar];
        navigationBarRect = [navBar convertRect:navBar.bounds toView:self.childControllerContainerView];
        navigationBarRect = CGRectIntersection(navigationBarRect,self.childControllerContainerView.bounds);
    }
    return CGRectContainsPoint(navigationBarRect,point);
}

- (BOOL)isPointContainedWithinCenterViewContentRect:(CGPoint)point{
    CGRect centerViewContentRect = self.centerContainerView.frame;
    centerViewContentRect = CGRectIntersection(centerViewContentRect,self.childControllerContainerView.bounds);
    return (CGRectContainsPoint(centerViewContentRect, point) &&
            [self isPointContainedWithinNavigationRect:point] == NO);
}

- (BOOL)isPointContainedWithinLeftBezelRect:(CGPoint)point{
    CGRect leftBezelRect = CGRectNull;
    CGRect tempRect;
    CGRectDivide(self.childControllerContainerView.bounds, &leftBezelRect, &tempRect, self.bezelPanningCenterViewRange, CGRectMinXEdge);
    return (CGRectContainsPoint(leftBezelRect, point) &&
            [self isPointContainedWithinCenterViewContentRect:point]);
}

- (BOOL)isPointContainedWithinRightBezelRect:(CGPoint)point{
    CGRect rightBezelRect = CGRectNull;
    CGRect tempRect;
    CGRectDivide(self.childControllerContainerView.bounds, &rightBezelRect, &tempRect, self.bezelPanningCenterViewRange, CGRectMaxXEdge);
    
    return (CGRectContainsPoint(rightBezelRect, point) &&
            [self isPointContainedWithinCenterViewContentRect:point]);
}
@end
