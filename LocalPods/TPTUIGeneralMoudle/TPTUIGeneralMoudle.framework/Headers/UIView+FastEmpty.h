//
//  UIView+FastEmpty.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/25.
//

#import <UIKit/UIKit.h>
@class UIGeneralEmptyView;
NS_ASSUME_NONNULL_BEGIN

@interface UIView (FastEmpty)

- (UIGeneralEmptyView *)addEmptyViewWithInGeneralBundleImageName:(NSString *)imageName
                                                           title:(NSString * _Nullable)title;
- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString * _Nullable)title;



- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString * _Nullable)title
                                      contnet:(NSString * _Nullable)content;

- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString *)title
                                  buttonTitle:(NSString *)buttonTitle
                                 buttonTarget:(id)buttonTarget
                                 buttonAction:(SEL)buttonAtion;
@end

NS_ASSUME_NONNULL_END
