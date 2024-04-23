//
//  UIGeneralAlert.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//
/// 弹框
#import <TPTCoreMoudle/UICommonViewController.h>
static CGFloat const kAlertActionButtonDefaultHeight = 48.f;

@class UIGeneralAlertAction;
typedef void(^AlertActionHandler)(UIGeneralAlertAction * _Nullable action);
typedef NS_ENUM(NSInteger, AlertStyle) {
    AlertStyle_Default,
    AlertStyle_Sheet
};

NS_ASSUME_NONNULL_BEGIN

@interface UIGeneralAlertAction : NSObject

@property(nonatomic, strong, readonly)id titleObjc;

/// 分割线高度 默认为0.5
@property(nonatomic, assign)CGFloat separatorLineHeight;

/// 按钮高度 默认为 kAlertActionButtonDefaultHeight
@property(nonatomic, assign)CGFloat buttonHeight;

/// 背景颜色 默认为 clearColor
@property(nonatomic, strong)UIColor *backgroundColor;

+ (instancetype)actionWithTitleObjc:(id)titleObjc;
+ (instancetype)actionWithTitleObjc:(id)titleObjc handler:(AlertActionHandler _Nullable)handler;



@end








@interface UIGeneralAlertController : UICommonViewController

/// 点击其他区域是否消失 Default:YES
@property(nonatomic, assign)BOOL tapOutsideToDismiss;
/// 蒙板背景色 Default：[UIColor clearColor]
@property(nonatomic, strong)UIColor *backgroundColor;

/// 弹窗内容背景色 Default：[UIColor colorWithHexString:@"FAFBFC"];
@property(nonatomic, strong)UIColor *contextBackgroundColor;

/// 分割线颜色 默认为 [UIColor colorWithWhite:0.94 alpha:1];
@property(nonatomic, strong)UIColor *separetorLineColor;

+ (instancetype)alertControllerWithStyle:(AlertStyle)style
                              alertTitle:(id)alertTitle
                            alertMessage:(id)alertMessage;
- (void)addAlertAction:(UIGeneralAlertAction *)action;
- (void)addAlertActions:(NSArray <UIGeneralAlertAction *> *)actions;
- (void)showWithPresentController:(UIViewController * _Nullable)present;
/// 插入顶部View 需要设定frame
/// inside 为NO
- (void)insertTopPaddingView:(UIView *)view;


///  插入顶部View 需要设定frame
/// - Parameters:
///   - view: view
///   - inside:  是否在弹窗内容区域内部
- (void)insertTopPaddingView:(UIView *)view inside:(BOOL)inside;

- (CGFloat)alertMaxWidth;
@end

NS_ASSUME_NONNULL_END
