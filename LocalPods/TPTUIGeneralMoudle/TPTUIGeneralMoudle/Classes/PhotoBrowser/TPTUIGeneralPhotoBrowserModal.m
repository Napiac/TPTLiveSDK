//
//  TPTUIGeneralPhotoBrowserModal.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import "TPTUIGeneralPhotoBrowserModal.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import "TPTUIGeneralMoudle.h"

@interface TPTUIGeneralPhotoBrowserModal ()
@property(nonatomic, strong)TPTUIGeneralPhotoBrowser * photoBrowser;
@property(nonatomic, strong)UIButton * closeButton;
@end

@implementation TPTUIGeneralPhotoBrowserModal

+ (instancetype)modalWithPhotos:(NSArray<NSString *> *)photoURLPaths
                   currentIndex:(NSInteger)currentIndex {
    TPTUIGeneralPhotoBrowserModal * modal = [TPTUIGeneralPhotoBrowserModal easeOut];
    modal.photoBrowser = [TPTUIGeneralPhotoBrowser browserWithPhotos:photoURLPaths currentIndex:currentIndex];
    modal.contentView.backgroundColor = [UIColor clearColor];
    [modal.contentView addSubview:modal.photoBrowser];
    [modal.contentView bringSubviewToFront:modal.closeButton];
    [modal performSelector:@selector(runStyle) withObject:nil afterDelay:kUICommonEaseOutModalAnimationDuration*2.f];
    return modal;
}

- (void)onContentLayout {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.closeButton.hidden = YES;
    [self.closeButton setImage:UIGeneralBusinessBundleLoadImage(@"general_icon_close") forState:UIControlStateNormal];
    self.closeButton.frame = CGRectMake(kScreenW-44.f, kSafeAreaStatusHeight, 44.f, 44.f);
    [self.contentView addSubview:self.closeButton];
    @weakify(self);
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self dismiss];
    }];
}

- (void)runStyle {
    self.closeButton.hidden = NO;
}

- (CGSize)contentSize {
    return CGSizeMake(kScreenW, kScreenH);
}
@end
