//
//  UIView+FastEmpty.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/25.
//

#import "UIView+FastEmpty.h"
#import "UIGeneralEmptyView.h"
#import "UIView+EmptyView.h"
#import "TPTUIGeneralMoudle.h"

@implementation UIView (FastEmpty)


- (UIGeneralEmptyView *)addEmptyViewWithInGeneralBundleImageName:(NSString *)imageName
                                                           title:(NSString * _Nullable)title {
    return [self addEmptyViewWithImage:UIGeneralBusinessBundleLoadImage(imageName) title:title];
}

- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString * _Nullable)title {
    UIGeneralEmptyView * emptyView = [UIGeneralEmptyView emptyViewWithImage:image
                                                            titleString:title
                                                          contnetString:nil
                                                  refreshButtonTapBlock:nil];
    self.emptyView = emptyView;
    return emptyView;
}


- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString * _Nullable)title
                                      contnet:(NSString * _Nullable)content {
    UIGeneralEmptyView * emptyView = [UIGeneralEmptyView emptyViewWithImage:image
                                                            titleString:title
                                                          contnetString:content
                                                  refreshButtonTapBlock:nil];
    self.emptyView = emptyView;
    return emptyView;
}

- (UIGeneralEmptyView *)addEmptyViewWithImage:(UIImage *)image
                                        title:(NSString *)title
                                  buttonTitle:(NSString *)buttonTitle
                                 buttonTarget:(id)buttonTarget
                                 buttonAction:(SEL)buttonAtion {
    UIGeneralEmptyView * emptyView = [UIGeneralEmptyView emptyViewWithImage:image
                                      titleString:title
                                    contnetString:nil
                         refreshButtonTitleString:buttonTitle
                              refreshButtonTarget:buttonTarget
                              refreshButtonAction:buttonAtion];
    self.emptyView = emptyView;
    return emptyView;
}

@end
