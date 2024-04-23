//
//  UICommonEmptyView.h
//  TPTUIGeneralMoudle
//
//  Created by 凡骄 on 2022/8/24.
//  基础空视图 View

#import <TPTCoreMoudle/UICommonView.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^EmptyTapBlock)(void); //点击block

@interface UIGeneralCommonEmptyView : UICommonView

@property(nonatomic, strong)UIView * contentView;
@property(nonatomic, strong, nullable)UIImage * image;
@property(nonatomic, copy, nullable)NSString * titleString;
@property(nonatomic, copy, nullable)NSString * contentString;
@property(nonatomic, copy, nullable)NSString * refreshButtonTitleString;
@property(nonatomic, weak, nullable)id refreshButtonTarget;
@property(nonatomic, assign, nullable)SEL refreshButtonAction;
@property(nonatomic, copy, nullable)EmptyTapBlock tapBlock;
@property(nonatomic, strong, nullable)UIView * customView;


+ (instancetype)emptyViewWithImage:(UIImage *)image
                       titleString:(NSString *)title
                     contnetString:(NSString * _Nullable)content
          refreshButtonTitleString:(NSString *)buttonTitle
               refreshButtonTarget:(id)buttonTarget
               refreshButtonAction:(SEL)buttonAtion;

+ (instancetype)emptyViewWithImage:(UIImage *)image
                       titleString:(NSString *)title
                     contnetString:(NSString * _Nullable)content
             refreshButtonTapBlock:(EmptyTapBlock _Nullable)ButtonTapBlock;

+ (instancetype)emptyViewWithCustomView:(UIView *)customView;

- (void)initializationUserInterface;
- (void)setupSubviews;

@end

NS_ASSUME_NONNULL_END
