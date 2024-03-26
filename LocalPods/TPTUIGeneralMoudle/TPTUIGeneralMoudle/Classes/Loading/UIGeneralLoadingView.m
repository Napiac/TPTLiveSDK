//
//  UIGeneralLoadingView.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/8/18.
//

#import "UIGeneralLoadingView.h"
#import "LOTAnimationView.h"
#import "TPTUIGeneralMoudle.h"

@interface UIGeneralLoadingView ()
@property(nonatomic, strong)LOTAnimationView * animationView;
@end

@implementation UIGeneralLoadingView

- (instancetype)initWithLodingText:(NSString * _Nullable)loadingText {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviewsWithLoadingText:loadingText];
    }
    return self;
}

- (void)setupSubviewsWithLoadingText:(NSString * _Nullable)loadingText {
    if (!loadingText || loadingText.length == 0) {
        [self addSubview:self.animationView];
        [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    } else {
        UIView * maskView = [[UIView alloc] init];
        maskView.backgroundColor = [[UIColor colorWithHexString:@"#F9F9F9"] colorWithAlphaComponent:0.94];
        maskView.layer.cornerRadius = 4.f;
        [self addSubview:maskView];
        [maskView addSubview:self.animationView];
        UILabel * textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont systemFontOfSize:12.f];
        textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.numberOfLines = 0;
        textLabel.text = loadingText;
        [maskView addSubview:textLabel];
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.mas_greaterThanOrEqualTo(85.f);
            make.width.mas_greaterThanOrEqualTo(130.f);
        }];
        
        [self.animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(maskView);
            make.size.mas_equalTo(CGSizeMake(56.f, 56.f));
        }];
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(maskView);
            make.top.equalTo(self.animationView.mas_bottom).offset(0.f);
            make.left.equalTo(maskView.mas_left).offset(4);
            make.right.equalTo(maskView.mas_right).offset(-4);
            make.bottom.mas_lessThanOrEqualTo(maskView.mas_bottom).offset(-4);
            make.width.mas_lessThanOrEqualTo(250.f);
        }];
    }
}


/// 显示
/// @param view 父视图
- (void)showInView:(UIView *)view{
    if (![NSThread isMainThread]) {
#if DEBUG
        NSAssert(NO, @"[UIGeneralLoadingView -showInView:]必须在主线程中调用");
#endif
        return;
    }
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (self.superview) {
        [self removeAfterDuration:0];
    }
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.animationView play];
}

/// 移除
- (void)remove{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(remove)
                                               object:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.animationView stop];
        [self removeFromSuperview];
    });
}

/// 几秒后移除
/// @param duration 时长
- (void)removeAfterDuration:(CGFloat)duration{
    [self performSelector:@selector(remove)
               withObject:nil
               afterDelay:duration];
}

/// 初始化并显示一个loading
/// @param view 父视图
+ (UIGeneralLoadingView *)showLoadingInView:(UIView *)view{
    UIGeneralLoadingView *loading = [[UIGeneralLoadingView alloc] initWithLodingText:nil];
    [loading showInView:view];
    return loading;
}

/// 初始化并显示一个带文字的loading
/// @param view 父试图
/// @param loadingText 文字
+ (UIGeneralLoadingView *)showLoadingInView:(UIView *)view loadingText:(NSString * _Nullable)loadingText {
    UIGeneralLoadingView *loading = [[UIGeneralLoadingView alloc] initWithLodingText:loadingText];
    [loading showInView:view];
    return loading;
}

/// 移除view上的loading
/// @param view 父视图
+ (void)removeFromView:(UIView *)view{
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:self]) {
            [(UIGeneralLoadingView *)obj remove];
        }
    }];
}

#pragma mark -
#pragma mark - Layinit
- (LOTAnimationView *)animationView{
    if (!_animationView) {
        NSString * filePath = [LoadBundle(kUIGeneralBusinessBundleName, kInUIGeneralBusinessMoudleClassName) pathForResource:@"loadingjson" ofType:@"json"];
        LOTAnimationView * animationView = [LOTAnimationView animationWithFilePath:filePath];
        animationView.frame = CGRectMake(0.f, 0.f, 60.f, 60.f);
        animationView.loopAnimation = YES;
        animationView.contentMode = UIViewContentModeScaleAspectFit;
        animationView.backgroundColor = [UIColor clearColor];
        _animationView = animationView;
    }
    return _animationView;
}
@end
