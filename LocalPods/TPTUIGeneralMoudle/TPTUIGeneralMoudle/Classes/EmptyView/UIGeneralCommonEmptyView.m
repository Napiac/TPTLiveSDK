//
//  UICommonEmptyView.m
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//

#import "UIGeneralCommonEmptyView.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@implementation UIGeneralCommonEmptyView

+ (instancetype)emptyViewWithImage:(UIImage *)image
                       titleString:(NSString *)title
                     contnetString:(NSString * _Nullable)content
          refreshButtonTitleString:(NSString *)buttonTitle
               refreshButtonTarget:(id)buttonTarget
               refreshButtonAction:(SEL)buttonAtion {
    return [self createEmptyImage:image
                      titleString:title
                    contentString:content
         refreshButtonTitleString:buttonTitle
              refreshButtonTarget:buttonTarget
              refreshButtonAction:buttonAtion
                         tapBlock:nil];
}

+ (instancetype)emptyViewWithImage:(UIImage *)image
                       titleString:(NSString *)title
                     contnetString:(NSString * _Nullable)content
             refreshButtonTapBlock:(EmptyTapBlock _Nullable)ButtonTapBlock {
    return [self createEmptyImage:image
                      titleString:title
                    contentString:content
         refreshButtonTitleString:nil
              refreshButtonTarget:nil
              refreshButtonAction:nil
                         tapBlock:ButtonTapBlock];
}

+ (instancetype)emptyViewWithCustomView:(UIView *)customView {
    return [self creatEmptyViewWithCustomView:customView];
}

+ (instancetype)createEmptyImage:(UIImage * __nullable)image
                     titleString:(NSString * __nullable)title
                   contentString:(NSString * __nullable)content
        refreshButtonTitleString:(NSString * __nullable)buttonTitle
             refreshButtonTarget:(id __nullable)buttonTarget
             refreshButtonAction:(SEL __nullable)buttonAtion
                        tapBlock:(EmptyTapBlock __nullable)tapBlock {
    UIGeneralCommonEmptyView *emptyView = [[self alloc] init];
    emptyView.image = image;
    emptyView.titleString = title;
    emptyView.contentString = content;
    emptyView.refreshButtonTitleString = buttonTitle;
    emptyView.refreshButtonTarget = buttonTarget;
    emptyView.refreshButtonAction = buttonAtion;
    emptyView.tapBlock = tapBlock;
    [emptyView setup];
    return emptyView;
}

+ (instancetype)creatEmptyViewWithCustomView:(UIView *)customView {
    UIGeneralCommonEmptyView *emptyView = [[self alloc] init];
    emptyView.customView = customView;
    [emptyView setup];
    return emptyView;
}




- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}

- (void)setup {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:_contentView];
    }
    if (_customView) {
        [_contentView addSubview:_customView];
    }
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGREmptyEvents:)];
    [self addGestureRecognizer:tapGR];
    
    [self initializationUserInterface];
    [self setupSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *view = self.superview;
    if (view && [view isKindOfClass:[UIView class]]) {
        self.width = view.width;
        self.height = view.height;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIView class]])
        return;
    if (newSuperview) {
        self.width = newSuperview.width;
        self.height = newSuperview.height;
    }
}

- (void)initializationUserInterface {}
- (void)setupSubviews {};


- (void)tapGREmptyEvents:(UIGestureRecognizer *)tapGR {
    if (_tapBlock) _tapBlock();
}

@end
