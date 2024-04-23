//
//  UIGeneralDrawerMenuController.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2023/3/30.
//

#import <TPTCoreMoudle/UICommonViewController.h>

typedef NS_ENUM(NSInteger, DrawerMenuSide){
    DrawerMenuSideNone = 0,
    DrawerMenuSideLeft,
    DrawerMenuSideRight,
};

typedef NS_OPTIONS(NSInteger, OpenDrawerGestureMode) {
    OpenDrawerGestureModeNone                     = 0,
    OpenDrawerGestureModePanningNavigationBar     = 1 << 1,
    OpenDrawerGestureModePanningCenterView        = 1 << 2,
    OpenDrawerGestureModeBezelPanningCenterView   = 1 << 3,
    OpenDrawerGestureModeCustom                   = 1 << 4,
    OpenDrawerGestureModeAll                      = OpenDrawerGestureModePanningNavigationBar     |
                                                    OpenDrawerGestureModePanningCenterView        |
                                                    OpenDrawerGestureModeBezelPanningCenterView   |
                                                    OpenDrawerGestureModeCustom,
};

typedef NS_OPTIONS(NSInteger, CloseDrawerGestureMode) {
    CloseDrawerGestureModeNone                    = 0,
    CloseDrawerGestureModePanningNavigationBar    = 1 << 1,
    CloseDrawerGestureModePanningCenterView       = 1 << 2,
    CloseDrawerGestureModeBezelPanningCenterView  = 1 << 3,
    CloseDrawerGestureModeTapNavigationBar        = 1 << 4,
    CloseDrawerGestureModeTapCenterView           = 1 << 5,
    CloseDrawerGestureModePanningDrawerView       = 1 << 6,
    CloseDrawerGestureModeCustom                  = 1 << 7,
    CloseDrawerGestureModeAll                     = CloseDrawerGestureModePanningNavigationBar    |
                                                    CloseDrawerGestureModePanningCenterView       |
                                                    CloseDrawerGestureModeBezelPanningCenterView  |
                                                    CloseDrawerGestureModeTapNavigationBar        |
                                                    CloseDrawerGestureModeTapCenterView           |
                                                    CloseDrawerGestureModePanningDrawerView       |
                                                    CloseDrawerGestureModeCustom,
};

typedef NS_ENUM(NSInteger, DrawerOpenCenterInteractionMode) {
    DrawerOpenCenterInteractionModeNone,
    DrawerOpenCenterInteractionModeFull,
    DrawerOpenCenterInteractionModeNavigationBarOnly,
};

@class UIGeneralDrawerMenuController;
typedef void (^DrawerControllerDrawerVisualStateBlock)(UIGeneralDrawerMenuController * drawerController, DrawerMenuSide drawerSide, CGFloat percentVisible);

@interface UIGeneralDrawerMenuController : UICommonViewController

///---------------------------------------
/// @name Accessing Drawer Container View Controller Properties
///---------------------------------------

/**
 The center view controller. 
 
 This can only be set via the init methods, as well as the `setNewCenterViewController:...` methods. The size of this view controller will automatically be set to the size of the drawer container view controller, and it's position is modified from within this class. Do not modify the frame externally.
 */
@property (nonatomic, strong) UIViewController * centerViewController;

/**
 The left drawer view controller. 
 
 The size of this view controller is managed within this class, and is automatically set to the appropriate size based on the `maximumLeftDrawerWidth`. Do not modify the frame externally.
 */
@property (nonatomic, strong) UIViewController * leftDrawerViewController;

/**
 The right drawer view controller. 
 
 The size of this view controller is managed within this class, and is automatically set to the appropriate size based on the `maximumRightDrawerWidth`. Do not modify the frame externally.
 */
@property (nonatomic, strong) UIViewController * rightDrawerViewController;

/**
 The maximum width of the `leftDrawerViewController`. 
 
 By default, this is set to 280. If the `leftDrawerViewController` is nil, this property will return 0.0;
 */
@property (nonatomic, assign) CGFloat maximumLeftDrawerWidth;

/**
 The maximum width of the `rightDrawerViewController`. 
 
 By default, this is set to 280. If the `rightDrawerViewController` is nil, this property will return 0.0;

 */
@property (nonatomic, assign) CGFloat maximumRightDrawerWidth;

/**
 The visible width of the `leftDrawerViewController`. 
 
 Note this value can be greater than `maximumLeftDrawerWidth` during the full close animation when setting a new center view controller;
 */
@property (nonatomic, assign, readonly) CGFloat visibleLeftDrawerWidth;

/**
 The visible width of the `rightDrawerViewController`. 
 
 Note this value can be greater than `maximumRightDrawerWidth` during the full close animation when setting a new center view controller;
 */
@property (nonatomic, assign, readonly) CGFloat visibleRightDrawerWidth;

/**
 The animation velocity of the open and close methods, measured in points per second.
 
 By default, this is set to 840 points per second (three times the default drawer width), meaning it takes 1/3 of a second for the `centerViewController` to open/close across the default drawer width. Note that there is a minimum .1 second duration for built in animations, to account for small distance animations.
 */
@property (nonatomic, assign) CGFloat animationVelocity;

/** 
 A boolean that determines whether or not the panning gesture will "hard-stop" at the maximum width for a given drawer side.
 
 By default, this value is set to YES. Enabling `shouldStretchDrawer` will give the pan a gradual asymptotic stopping point much like `UIScrollView` behaves. Note that if this value is set to YES, the `drawerVisualStateBlock` can be passed a `percentVisible` greater than 1.0, so be sure to handle that case appropriately.
 */
@property (nonatomic, assign) BOOL shouldStretchDrawer;

/**
 The current open side of the drawer. 
 
 Note this value will change as soon as a pan gesture opens a drawer, or when a open/close animation is finished.
 */
@property (nonatomic, assign, readonly) DrawerMenuSide openSide;

/**
 How a user is allowed to open a drawer using gestures. 
 
 By default, this is set to `OpenDrawerGestureModeNone`. Note these gestures may affect user interaction with the `centerViewController`, so be sure to use appropriately.
 */
@property (nonatomic, assign) OpenDrawerGestureMode openDrawerGestureModeMask;

/**
 How a user is allowed to close a drawer. 
 
 By default, this is set to `CloseDrawerGestureModeNone`. Note these gestures may affect user interaction with the `centerViewController`, so be sure to use appropriately.
 */
@property (nonatomic, assign) CloseDrawerGestureMode closeDrawerGestureModeMask;

/**
 The value determining if the user can interact with the `centerViewController` when a side drawer is open. 
 
 By default, it is `DrawerOpenCenterInteractionModeNavigationBarOnly`, meaning that the user can only interact with the buttons on the `UINavigationBar`, if the center view controller is a `UINavigationController`. Otherwise, the user cannot interact with any other center view controller elements.
 */
@property (nonatomic, assign) DrawerOpenCenterInteractionMode centerHiddenInteractionMode;

/**
 The flag determining if a shadow should be drawn off of `centerViewController` when a drawer is open. 
 
 By default, this is set to YES.
 */
@property (nonatomic, assign) BOOL showsShadow;

/**
 The shadow radius of `centerViewController` when a drawer is open.
 
 By default, this is set to 10.0f;
 */
@property (nonatomic, assign) CGFloat shadowRadius;

/**
 The shadow opacity of `centerViewController` when a drawer is open.
 
 By default, this is set to 0.8f;
 */
@property (nonatomic, assign) CGFloat shadowOpacity;

/**
 The shadow offset of `centerViewController` when a drawer is open.
 
 By default, this is set to (0, -3);
 */
@property (nonatomic, assign) CGSize shadowOffset;

/**
 The color of the shadow drawn off of 'centerViewController` when a drawer is open.
 
 By default, this is set to the systme default (opaque black).
 */
@property (nonatomic, strong) UIColor * shadowColor;

/**
 The flag determining if a custom background view should appear beneath the status bar, forcing the child content to be drawn lower than the status bar.
 
 By default, this is set to NO.
 */
@property (nonatomic, assign) BOOL showsStatusBarBackgroundView;

/**
 The color of the status bar background view if `showsStatusBarBackgroundView` is set to YES.
 
 By default, this is set `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor * statusBarViewBackgroundColor;

/**
 The value determining panning range of centerView's bezel if the user can open drawer with 'OpenDrawerGestureModeBezelPanningCenterView' or close drawer with 'CloseDrawerGestureModeBezelPanningCenterView' .
 
 By default, this is set 20.0f.
 */
@property (nonatomic, assign) CGFloat bezelPanningCenterViewRange;

/**
 The value determining if the user can open or close drawer with panGesture velocity.
 
 By default, this is set 200.0f.
 */
@property (nonatomic, assign) CGFloat panVelocityXAnimationThreshold;

///---------------------------------------
/// @name Initializing a `UIGeneralDrawerMenuController`
///---------------------------------------

/**
 Creates and initializes an `UIGeneralDrawerMenuController` object with the specified center view controller, left drawer view controller, and right drawer view controller.
 
 @param centerViewController The center view controller. This argument must not be `nil`.
 @param leftDrawerViewController The left drawer view controller.
 @param rightDrawerViewController The right drawer controller.
 
 @return The newly-initialized drawer container view controller.
 */
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController;

/**
 Creates and initializes an `UIGeneralDrawerMenuController` object with the specified center view controller, left drawer view controller.
 
 @param centerViewController The center view controller. This argument must not be `nil`.
 @param leftDrawerViewController The left drawer view controller.
 
 @return The newly-initialized drawer container view controller.
 */
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController leftDrawerViewController:(UIViewController *)leftDrawerViewController;

/**
 Creates and initializes an `UIGeneralDrawerMenuController` object with the specified center view controller, right drawer view controller.
 
 @param centerViewController The center view controller. This argument must not be `nil`.
 @param rightDrawerViewController The right drawer controller.
 
 @return The newly-initialized drawer container view controller.
 */
- (instancetype)initWithCenterViewController:(UIViewController *)centerViewController rightDrawerViewController:(UIViewController *)rightDrawerViewController;

///---------------------------------------
/// @name Opening and Closing a Drawer
///---------------------------------------

/**
 Toggles the drawer open/closed based on the `drawer` passed in. 
 
 Note that if you attempt to toggle a drawer closed while the other is open, nothing will happen. For example, if you pass in DrawerSideLeft, but the right drawer is open, nothing will happen. In addition, the completion block will be called with the finished flag set to NO.
 
 @param drawerSide The `DrawerSide` to toggle. This value cannot be `DrawerSideNone`.
 @param animated Determines whether the `drawer` should be toggle animated.
 @param completion The block that is called when the toggle is complete, or if no toggle took place at all.
 
 */
- (void)toggleDrawerSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated completion:(void(^)(BOOL finished))completion;

/**
 Closes the open drawer.
 
 @param animated Determines whether the drawer side should be closed animated
 @param completion The block that is called when the close is complete
 
 */
- (void)closeDrawerAnimated:(BOOL)animated completion:(void(^)(BOOL finished))completion;

/**
 Opens the `drawer` passed in.
 
 @param drawerSide The `DrawerSide` to open. This value cannot be `DrawerSideNone`.
 @param animated Determines whether the `drawer` should be open animated.
 @param completion The block that is called when the toggle is open.
 
 */
- (void)openDrawerSide:(DrawerMenuSide)drawerSide animated:(BOOL)animated completion:(void(^)(BOOL finished))completion;

///---------------------------------------
/// @name Setting a new Center View Controller
///---------------------------------------

/**
 Sets the new `centerViewController`. 
 
 This sets the view controller and will automatically adjust the frame based on the current state of the drawer controller. If `closeAnimated` is YES, it will immediately change the center view controller, and close the drawer from its current position.
 
 @param centerViewController The new `centerViewController`.
 @param closeAnimated Determines whether the drawer should be closed with an animation.
 @param completion The block called when the animation is finsihed.
 
 */
- (void)setCenterViewController:(UIViewController *)centerViewController withCloseAnimation:(BOOL)closeAnimated completion:(void(^)(BOOL finished))completion;

/**
 Sets the new `centerViewController`. 
 
 This sets the view controller and will automatically adjust the frame based on the current state of the drawer controller. If `closeFullAnimated` is YES, the current center view controller will animate off the screen, the new center view controller will then be set, followed by the drawer closing across the full width of the screen.
 
 @param newCenterViewController The new `centerViewController`.
 @param fullCloseAnimated Determines whether the drawer should be closed with an animation.
 @param completion The block called when the animation is finsihed.
 
 */
- (void)setCenterViewController:(UIViewController *)newCenterViewController withFullCloseAnimation:(BOOL)fullCloseAnimated completion:(void(^)(BOOL finished))completion;

///---------------------------------------
/// @name Animating the Width of a Drawer
///---------------------------------------

/**
 Sets the maximum width of the left drawer view controller. 
 
 If the drawer is open, and `animated` is YES, it will animate the drawer frame as well as adjust the center view controller. If the drawer is not open, this change will take place immediately.
 
 @param width The new width of left drawer view controller. This must be greater than zero.
 @param animated Determines whether the drawer should be adjusted with an animation.
 @param completion The block called when the animation is finished.
 
 */
- (void)setMaximumLeftDrawerWidth:(CGFloat)width animated:(BOOL)animated completion:(void(^)(BOOL finished))completion;

/**
 Sets the maximum width of the right drawer view controller. 
 
 If the drawer is open, and `animated` is YES, it will animate the drawer frame as well as adjust the center view controller. If the drawer is not open, this change will take place immediately.
 
 @param width The new width of right drawer view controller. This must be greater than zero.
 @param animated Determines whether the drawer should be adjusted with an animation.
 @param completion The block called when the animation is finished.
 
 */
- (void)setMaximumRightDrawerWidth:(CGFloat)width animated:(BOOL)animated completion:(void(^)(BOOL finished))completion;

///---------------------------------------
/// @name Previewing a Drawer
///---------------------------------------

/**
 Bounce preview for the specified `drawerSide` a distance of 40 points.
 
 @param drawerSide The drawer to preview. This value cannot be `DrawerSideNone`.
 @param completion The block called when the animation is finsihed.
 
 */
- (void)bouncePreviewForDrawerSide:(DrawerMenuSide)drawerSide completion:(void(^)(BOOL finished))completion;

/**
 Bounce preview for the specified `drawerSide`.
 
 @param drawerSide The drawer side to preview. This value cannot be `DrawerSideNone`.
 @param distance The distance to bounce.
 @param completion The block called when the animation is finsihed.
 
 */
- (void)bouncePreviewForDrawerSide:(DrawerMenuSide)drawerSide distance:(CGFloat)distance completion:(void(^)(BOOL finished))completion;

///---------------------------------------
/// @name Custom Drawer Animations
///---------------------------------------

/**
 Sets a callback to be called when a drawer visual state needs to be updated. 
 
 This block is responsible for updating the drawer's view state, and the drawer controller will handle animating to that state from the current state. This block will be called when the drawer is opened or closed, as well when the user is panning the drawer. This block is not responsible for doing animations directly, but instead just updating the state of the properies (such as alpha, anchor point, transform, etc). Note that if `shouldStretchDrawer` is set to YES, it is possible for `percentVisible` to be greater than 1.0. If `shouldStretchDrawer` is set to NO, `percentVisible` will never be greater than 1.0.
 
 Note that when the drawer is finished opening or closing, the side drawer controller view will be reset with the following properies:
 
    - alpha: 1.0
    - transform: CATransform3DIdentity
    - anchorPoint: (0.5,0.5)
 
 @param drawerVisualStateBlock A block object to be called that allows the implementer to update visual state properties on the drawer. `percentVisible` represents the amount of the drawer space that is current visible, with drawer space being defined as the edge of the screen to the maxmimum drawer width. Note that you do have access to the drawerController, which will allow you to update things like the anchor point of the side drawer layer.
 */
- (void)setDrawerVisualStateBlock:(void(^)(UIGeneralDrawerMenuController * drawerController, DrawerMenuSide drawerSide, CGFloat percentVisible))drawerVisualStateBlock;

///---------------------------------------
/// @name Gesture Completion Handling
///---------------------------------------

/**
 Sets a callback to be called when a gesture has been completed.
 
 This block is called when a gesture action has been completed. You can query the `openSide` of the `drawerController` to determine what the new state of the drawer is.
 
 @param gestureCompletionBlock A block object to be called that allows the implementer be notified when a gesture action has been completed.
 */
- (void)setGestureCompletionBlock:(void(^)(UIGeneralDrawerMenuController * drawerController, UIGestureRecognizer * gesture))gestureCompletionBlock;

///---------------------------------------
/// @name Custom Gesture Handler
///---------------------------------------

/**
 Sets a callback to be called to determine if a UIGestureRecognizer should recieve the given UITouch.
 
 This block provides a way to allow a gesture to be recognized with custom logic. For example, you may have a certain part of your view that should accept a pan gesture recognizer to open the drawer, but not another a part. If you return YES, the gesture is recognized and the appropriate action is taken. This provides similar support to how Facebook allows you to pan on the background view of the main table view, but not the content itself. You can inspect the `openSide` property of the `drawerController` to determine the current state of the drawer, and apply the appropriate logic within your block.
 
 Note that either `openDrawerGestureModeMask` must contain `OpenDrawerGestureModeCustom`, or `closeDrawerGestureModeMask` must contain `CloseDrawerGestureModeCustom` for this block to be consulted.
 
 @param gestureShouldRecognizeTouchBlock A block object to be called to determine if the given `touch` should be recognized by the given gesture.
 */
- (void)setGestureShouldRecognizeTouchBlock:(BOOL(^)(UIGeneralDrawerMenuController * drawerController, UIGestureRecognizer * gesture, UITouch * touch))gestureShouldRecognizeTouchBlock;

@end
