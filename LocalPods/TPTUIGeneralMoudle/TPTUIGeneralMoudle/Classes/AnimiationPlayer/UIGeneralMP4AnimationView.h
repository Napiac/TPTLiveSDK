//
//  UIGeneralSVGAAnimationView.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//

/// 透明通道MP4文件播放器
#import <TPTCoreMoudle/UICommonView.h>
#import <QGVAPlayer/QGVAPWrapView.h>
@class RACSignal;
NS_ASSUME_NONNULL_BEGIN

@interface UIGeneralMP4AnimationView : UICommonView

/// 重复次数 无限重复 = -1 Defult : 0
@property (nonatomic, assign)NSInteger repeatMax;

+ (instancetype)mp4AnimationViewFrame:(CGRect)frame
                          svgaDelegate:(id<VAPWrapViewDelegate>)delegate;

- (RACSignal *)startAnimationInResultSignalWithFilePath:(NSString *)filePath;

- (void)setupMute:(BOOL)mute;
- (void)pausePlayer;
- (void)unInitPlayer;
@end

NS_ASSUME_NONNULL_END
