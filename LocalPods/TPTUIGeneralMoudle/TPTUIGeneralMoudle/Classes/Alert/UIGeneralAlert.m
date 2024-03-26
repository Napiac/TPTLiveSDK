//
//  UIGeneralAlert.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import "UIGeneralAlert.h"
#import <TPTCoreMoudle/UICommontButton.h>
#import <TPTCoreMoudle/UIColor+Color.h>
#import <TPTCoreMoudle/UIView+Frame.h>
#import <TPTCoreMoudle/UIView+View.h>
#import <TPTCoreMoudle/UILabel+Style.h>
#import <ReactiveObjC/ReactiveObjC.h>
static NSString * const kAlertDefaultGrayColorHEX = @"5E6066";


@interface UIGeneralAlertButton : UICommontButton
@property(nonatomic, strong)UIColor * highlightedColor;
@end

@implementation UIGeneralAlertButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted && self.highlightedColor) {
        self.backgroundColor = self.highlightedColor;
    } else {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            self.backgroundColor = nil;
        });
    }
}
@end







@interface UIGeneralAlertAction ()
@property(nonatomic, strong)id titleObjc;
@property(nonatomic, copy)AlertActionHandler handler;
@end

@implementation UIGeneralAlertAction

+ (instancetype)actionWithTitleObjc:(id)titleObjc {
    return [self actionWithTitleObjc:titleObjc handler:NULL];
}

+ (instancetype)actionWithTitleObjc:(id)titleObjc handler:(AlertActionHandler _Nullable)handler {
    UIGeneralAlertAction * action = [UIGeneralAlertAction new];
    action.handler = handler;
    action.titleObjc = titleObjc;
    return action;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.separatorLineHeight = 0.5;
        self.backgroundColor = [UIColor clearColor];
        self.buttonHeight = kAlertActionButtonDefaultHeight;
    }
    return self;
}
@end










@interface UIGeneralAlertController ()
@property(nonatomic, assign)AlertStyle alertStyle;
@property(nonatomic, copy)id  alertTitle;
@property(nonatomic, copy)id  alertMessage;

@property(nonatomic, strong)UILabel * alertTitleLabel;
@property(nonatomic, strong)UILabel * alertMessageLabel;

@property(nonatomic, strong, nullable)UIView *topPaddingView;
@property(nonatomic, assign) BOOL topViewInside;

@property(nonatomic, strong)UIView * alertMaskView;
@property(nonatomic, strong)UIView * alertContextView;

@property(nonatomic, strong)NSMutableArray <UIGeneralAlertAction *>* alertActions;
@end

@implementation UIGeneralAlertController

+ (instancetype)alertControllerWithStyle:(AlertStyle)style
                              alertTitle:(id)alertTitle
                            alertMessage:(id)alertMessage {
    UIGeneralAlertController * alertController = [[UIGeneralAlertController alloc] init];
    alertController.alertStyle = style;
    alertController.alertTitle = alertTitle;
    alertController.alertMessage = alertMessage;
    return alertController;
}

/// 插入顶部View 需要设定frame
- (void)insertTopPaddingView:(UIView *)view {
    [self insertTopPaddingView:view inside:NO];
}
///  插入顶部View 需要设定frame
/// - Parameters:
///   - view: view
///   - inside:  是否在弹窗内容区域内部
- (void)insertTopPaddingView:(UIView *)view inside:(BOOL)inside {
    self.topPaddingView = view;
    self.topViewInside = inside;
}


- (void)addAlertAction:(UIGeneralAlertAction *)action {
    [self addAlertActions:@[action]];
}

- (void)addAlertActions:(NSArray <UIGeneralAlertAction *> *)actions {
    [self.alertActions addObjectsFromArray:actions];
}

- (void)showWithPresentController:(UIViewController * _Nullable)present {
    if (!present) {
        present = [[UIApplication sharedApplication].delegate window].rootViewController;
    }
    [present presentViewController:self animated:NO completion:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.tapOutsideToDismiss = YES;
        self.contextBackgroundColor = [UIColor colorWithHexString:@"FAFBFC"];
        self.backgroundColor = [UIColor clearColor];
        self.separetorLineColor = [UIColor colorWithWhite:0.94 alpha:1];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.view.backgroundColor = self.backgroundColor;
    [self updateAlertTitleLabelFrame];
    [self updateAlertMessageLabelFrame];
    [self updateAlertActionButtonsFrame];
    [self updateAlertActionSeparatorLineFrame];
    [self updateAlertFrame];
    [self updateTopPaddingViewFrame];
}

- (UIStatusBarStyle)statusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (!CGRectContainsPoint(self.alertMaskView.frame, touchPoint) && !CGRectContainsPoint(self.topPaddingView.frame, touchPoint) && self.tapOutsideToDismiss) {
        [self showDisappearAnimation:nil];
    } else {
        [super touchesBegan:touches withEvent:event];
    }
}


- (void)initializationUserInterface {
    self.view.backgroundColor = self.backgroundColor;
    [self.view addSubview:self.alertMaskView];
    if (self.topPaddingView && !self.topViewInside) {
        [self.view addSubview:self.topPaddingView];
    }
    if (self.topPaddingView && self.topViewInside) {
        [self.alertContextView addSubview:self.topPaddingView];
    }
    [self initActionButtonUI];
    [self initActionSeparatorLineUI];
    [self showAppearAnimation];
}


- (void)initActionButtonUI {
    for (int i = 0; i<self.actions.count; i++) {
        UIGeneralAlertAction * obj = self.actions[i];
        UIGeneralAlertButton * alertButton = [UIGeneralAlertButton buttonWithType:UIButtonTypeCustom];
        alertButton.tag = 101+i;
        alertButton.highlightedColor = [UIColor colorWithWhite:0.97 alpha:1];
        alertButton.backgroundColor = obj.backgroundColor;
        alertButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [alertButton setTitleColor:[UIColor colorWithHexString:kAlertDefaultGrayColorHEX] forState:UIControlStateNormal];
        [alertButton addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertContextView addSubview:alertButton];
        
        if ([obj.titleObjc isKindOfClass:NSString.class]) {
            [alertButton setTitle:obj.titleObjc forState:UIControlStateNormal];
        } else {
            [alertButton setAttributedTitle:obj.titleObjc forState:UIControlStateNormal];
        }
    }
}

- (void)initActionSeparatorLineUI {
    if (self.actions.count == 0) {
        return;
    }
    NSInteger count = (self.actions.count > 2 || [self sheetStyleAlert]) ? self.actions.count : 1;
    count -= ([self.alertTitle length] || [self.alertMessage length]) ? 0 : 1;
    for (int i=0; i<count; i++) {
        UIView * lineView = [UIView new];
        lineView.tag = 1001+i;
        lineView.backgroundColor = self.separetorLineColor;
        [self.alertContextView addSubview:lineView];
    }
    /// 判断是两个横向按钮 添加一条中间竖线
    if ((self.actions.count == 2) && ![self sheetStyleAlert]) {
        UIView * lineView = [UIView new];
        lineView.tag = 1000;
        lineView.backgroundColor = self.separetorLineColor;
        [self.alertContextView addSubview:lineView];
    }
}

- (void)changeLineColor {
    if (self.actions.count == 0) {
        return;
    }
    NSInteger count = (self.actions.count > 2 || [self sheetStyleAlert]) ? self.actions.count : 1;
    count -= ([self.alertTitle length] || [self.alertMessage length]) ? 0 : 1;
    for (int i=0; i<count; i++) {
        UIView * lineView = [self.alertContextView viewWithTag:1001+i];
        lineView.backgroundColor = self.separetorLineColor;
    }
    if ((self.actions.count == 2) && ![self sheetStyleAlert]) {
        UIView * lineView = [self.alertContextView viewWithTag:1000];
        lineView.backgroundColor = self.separetorLineColor;
    }
}

- (void)showAppearAnimation {
    self.alertMaskView.alpha = 0;
    self.topPaddingView.alpha = 0;
    self.alertMaskView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    @weakify(self);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.55
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
        @strongify(self);
        self.alertMaskView.transform = CGAffineTransformIdentity;
        self.alertMaskView.alpha = 1;
        self.topPaddingView.alpha = 1;
    } completion:NULL];
}

- (void)showDisappearAnimation:(UIGeneralAlertAction *)action {
    @weakify(self);
    [UIView animateWithDuration:0.1
                     animations:^{
        @strongify(self);
        self.alertContextView.alpha = 0;
        self.topPaddingView.alpha = 0;
    } completion:^(BOOL finished) {
        @strongify(self);
        UIViewController *parentViewController = self.presentingViewController;
        @weakify(parentViewController);
        [self dismissViewControllerAnimated:NO completion:^{
            if (action && action.handler) {
                action.handler(action);
            }
            @strongify(parentViewController);
            [parentViewController setNeedsStatusBarAppearanceUpdate];
        }];
    }];
}


#pragma mark -
#pragma mark - Update Frame

- (void)updateTopPaddingViewFrame {
    if (self.topPaddingView) {
        if (!self.topViewInside) {
            self.topPaddingView.y = self.alertMaskView.y - 16 - self.topPaddingView.height;
        }
    }
}

- (void)updateAlertTitleLabelFrame {
    if ([self.alertTitle length] > 0) {
        CGFloat alertTitleLabelWidth = self.alertMaxWidth-self.margin.left-self.margin.right;
        CGSize size = [self.alertTitleLabel sizeThatFits:CGSizeMake(alertTitleLabelWidth, CGFLOAT_MAX)];
        
        if (self.topPaddingView && self.topViewInside) {
            self.alertTitleLabel.frame = CGRectMake(self.margin.left,
                                                    self.margin.top + self.topPaddingView.y+self.topPaddingView.height,
                                                    alertTitleLabelWidth,
                                                    size.height);
        } else {
            self.alertTitleLabel.frame = CGRectMake(self.margin.left,
                                                    self.margin.top,
                                                    alertTitleLabelWidth,
                                                    size.height);
        }
    }
}


- (void)updateAlertMessageLabelFrame {
    
    if ([self.alertMessage length] > 0) {
        CGFloat alertMessageLabelWidth = self.alertMaxWidth-self.margin.left-self.margin.right;
        CGFloat alertMessageLabelY = ([self.alertTitle length] > 0) ? (CGRectGetMaxY(self.alertTitleLabel.frame)+20.f):self.margin.top;
        if ([self.alertTitle length] == 0 && self.topPaddingView && self.topViewInside) {
            alertMessageLabelY = self.margin.top + self.topPaddingView.y+self.topPaddingView.height;
        }
        CGSize size = [self.alertMessageLabel sizeThatFits:CGSizeMake(alertMessageLabelWidth, CGFLOAT_MAX)];
        self.alertMessageLabel.frame = CGRectMake(self.margin.left,
                                                  alertMessageLabelY,
                                                  alertMessageLabelWidth,
                                                  size.height);
    }
}

- (void)updateAlertActionButtonsFrame {
    if (self.actions.count == 0) {
        return;
    }
    CGFloat firstButtonY = self.firstActionButtonY;
    CGFloat width = (self.actions.count > 2) ? self.alertMaxWidth : self.alertMaxWidth/self.actions.count;
    if ([self sheetStyleAlert]) {
        width = self.alertMaxWidth;
    }
    CGFloat upButtonMaxY = firstButtonY;
    for (int i = 0; i<self.actions.count; i++) {
        UIGeneralAlertButton * button = [self.alertContextView viewWithTag:101+i];
        CGFloat x = (self.actions.count > 2) ? 0 : width*i;
        CGFloat y = (self.actions.count > 2) ? upButtonMaxY : firstButtonY;
        if ([self sheetStyleAlert] || (self.actions.count > 2)) {
            x = 0.f;
            y = upButtonMaxY;
            if (i > 0) {
                y += self.actions[i].separatorLineHeight;
            }
            upButtonMaxY = y + self.actions[i].buttonHeight;
        }
        button.frame = CGRectMake(x, y, width, self.actions[i].buttonHeight);
    }
}

- (void)updateAlertActionSeparatorLineFrame {
    NSInteger count = (self.actions.count > 2 || self.alertStyle == AlertStyle_Sheet) ? self.actions.count : 1;
    count -= ([self.alertTitle length]>0 || [self.alertMessage length]>0) ? 0 : 1;
    NSInteger offset = ([self.alertTitle length]>0 || [self.alertMessage length]>0) ? 0 : 1;
    for (int i = 0; i<count; i++) {
        UIView * lineView = [self.alertContextView viewWithTag:1001+i];
        UIButton * button = [self.alertContextView viewWithTag:101+i+offset];
        CGFloat x = button.frame.origin.x;
        CGFloat y = button.frame.origin.y;
        if (i==0) {
            UIView * _Nullable otherlineView = [self.alertContextView viewWithTag:1000];
             if (otherlineView) {
                 otherlineView.frame = CGRectMake((self.alertMaxWidth - 0.5)/2.f, y, 0.5, self.actions[i+offset].buttonHeight);
             }
        }
        CGFloat width = self.alertMaxWidth;
        if ([self sheetStyleAlert]) {
            width = self.alertMaxWidth;
        }
        lineView.frame = CGRectMake(x, y-self.actions[i+offset].separatorLineHeight, width, self.actions[i+offset].separatorLineHeight);
    }
  
}

- (void)updateAlertFrame {
    CGFloat firstButtonY = self.firstActionButtonY;
    __block CGFloat buttonTotalHeight = 0.f;
    if (self.actions.count == 0) {
        buttonTotalHeight = 0.f;
    } else if (self.actions.count < 3) {
        [self.actions enumerateObjectsUsingBlock:^(UIGeneralAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.buttonHeight > buttonTotalHeight) {
                buttonTotalHeight = obj.buttonHeight;
            }
        }];
    } else {
        [self.actions enumerateObjectsUsingBlock:^(UIGeneralAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            buttonTotalHeight += (obj.buttonHeight+obj.separatorLineHeight);
        }];
    }
    if ([self sheetStyleAlert]) {
        buttonTotalHeight = 0;
        [self.actions enumerateObjectsUsingBlock:^(UIGeneralAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            buttonTotalHeight += (obj.buttonHeight+obj.separatorLineHeight);
        }];
    }
    CGFloat maskViewHeight = firstButtonY+buttonTotalHeight;
    CGFloat y = [self sheetStyleAlert] ? self.view.height-maskViewHeight : (self.view.height-maskViewHeight)/2.f;
    UIRectCorner c = [self sheetStyleAlert] ? (UIRectCornerTopLeft | UIRectCornerTopRight) : UIRectCornerAllCorners;
    
    self.alertMaskView.frame = CGRectMake((self.view.width-self.alertMaxWidth)/2.f,
                                          y,
                                          self.alertMaxWidth,
                                          maskViewHeight);
    self.alertContextView.frame = self.alertMaskView.bounds;
    [self.alertContextView setRoundedCorners:c radius:12.f];
}


#pragma mark -
#pragma mark - Clicked

- (void)actionClicked:(UIGeneralAlertButton *)sender {
    UIGeneralAlertAction * action = self.actions[sender.tag-101];
    [self showDisappearAnimation:action];
}

#pragma mark -
#pragma mark - Get / Set
- (void)setContextBackgroundColor:(UIColor *)contextBackgroundColor {
    _contextBackgroundColor = contextBackgroundColor;
    _alertContextView.backgroundColor = contextBackgroundColor;
}

- (void)setSeparetorLineColor:(UIColor *)separetorLineColor {
    _separetorLineColor = separetorLineColor;
    [self changeLineColor];
}

- (BOOL)sheetStyleAlert {
    return self.alertStyle == AlertStyle_Sheet;
}

- (CGFloat)alertMaxWidth {
    return [self sheetStyleAlert] ? self.view.width : 280.f;
}

- (NSArray <UIGeneralAlertAction *> *)actions {
    return [NSArray arrayWithArray:self.alertActions];
}

- (UIEdgeInsets)margin {
    return UIEdgeInsetsMake(25.f, 20.f, 0.f, 20.f);
}

- (CGFloat)firstActionButtonY {
    CGFloat firstButtonY = 0;
    if ([self.alertTitle length] > 0) {
        firstButtonY = CGRectGetMaxY(self.alertTitleLabel.frame);
    }
    if ([self.alertMessage length]) {
        firstButtonY = CGRectGetMaxY(self.alertMessageLabel.frame);
    }
    firstButtonY += firstButtonY>0 ? 15 : 0;
    return firstButtonY;
}

#pragma mark -
#pragma mark - Lazy Init

- (UIView *)alertMaskView {
    if (!_alertMaskView) {
        _alertMaskView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.alertMaxWidth, 0.f)];
        _alertMaskView.layer.masksToBounds = NO;
        _alertMaskView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.25f].CGColor;
        _alertMaskView.layer.shadowRadius = 20.f;
        _alertMaskView.layer.shadowOpacity = 1.f;
        _alertMaskView.layer.shadowOffset = CGSizeMake(0.f, 10.f);
    }
    return _alertMaskView;
}

- (UIView *)alertContextView {
    if (!_alertContextView) {
        _alertContextView = [[UIView alloc] initWithFrame:self.alertMaskView.bounds];
        _alertContextView.backgroundColor = self.contextBackgroundColor;
        _alertContextView.clipsToBounds = YES;
        [self.alertMaskView addSubview:_alertContextView];
    }
    return _alertContextView;
}

- (UILabel *)alertTitleLabel {
    if (!_alertTitleLabel) {
        _alertTitleLabel = [UILabel new];
        _alertTitleLabel.font = [UIFont systemFontOfSize:20.f];
        _alertTitleLabel.numberOfLines = 0;
        _alertTitleLabel.textColor = [UIColor colorWithHexString:kAlertDefaultGrayColorHEX];
        _alertTitleLabel.needAutoLineSpace = YES;
        if ([self.alertTitle isKindOfClass:[NSAttributedString class]]) {
            _alertTitleLabel.attributedText = self.alertTitle;
        } else if ([self.alertMessage isKindOfClass:[NSString class]]){
            _alertTitleLabel.text = self.alertTitle;
        }
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertContextView addSubview:_alertTitleLabel];
    }
    return _alertTitleLabel;
}

- (UILabel *)alertMessageLabel {
    if (!_alertMessageLabel) {
        _alertMessageLabel = [UILabel new];
        _alertMessageLabel.font = [UIFont systemFontOfSize:14.f];
        _alertMessageLabel.numberOfLines = 0;
        _alertMessageLabel.textColor = [UIColor colorWithHexString:kAlertDefaultGrayColorHEX];
        _alertMessageLabel.needAutoLineSpace = YES;
        if ([self.alertMessage isKindOfClass:[NSAttributedString class]]) {
            _alertMessageLabel.attributedText = self.alertMessage;
        } else if ([self.alertMessage isKindOfClass:[NSString class]]){
            _alertMessageLabel.text = self.alertMessage;
        }
        _alertMessageLabel.textAlignment = NSTextAlignmentCenter;
        [self.alertContextView addSubview:_alertMessageLabel];
    }
    return _alertMessageLabel;
}

- (NSMutableArray<UIGeneralAlertAction *> *)alertActions {
    if (!_alertActions) {
        _alertActions = [NSMutableArray array];
    }
    return _alertActions;
}
@end
