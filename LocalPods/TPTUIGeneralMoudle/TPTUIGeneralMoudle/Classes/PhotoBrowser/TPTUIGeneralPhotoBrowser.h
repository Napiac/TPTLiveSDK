//
//  TPTUIGeneralPhotoBrowser.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

/// 照片浏览器
#import <TPTCoreMoudle/UICommonView.h>

NS_ASSUME_NONNULL_BEGIN



@interface TPTUIGeneralPhotoBrowser : UICommonView
/// 是否支持自动滚动 Default:YES
@property(nonatomic, assign)BOOL supportAutoScroll;
/// 支持下载 Default:YES
@property(nonatomic, assign)BOOL supportDownload;
/// 是否显示分页 Default:YES
@property(nonatomic, assign)BOOL showPageControl;
/// 分页器底部间距
/// Default: 60
@property(nonatomic, assign)CGFloat pageControlBottomPadding;


@property(nonatomic, copy)void(^itemClickBlock)(NSInteger index);

+ (instancetype)browserWithPhotos:(NSArray <NSString *> *)photoURLPaths
                     currentIndex:(NSInteger)currentIndex;


+ (instancetype)browserWithVideos:(NSArray <NSString *> *)videoURLPaths
                     currentIndex:(NSInteger)currentIndex;
@end

NS_ASSUME_NONNULL_END
