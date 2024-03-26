//
//  UIGeneralSVGAAnimationView.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//
/// SVGA文件播放器
#import <TPTCoreMoudle/UICommonView.h>
#import "TPTSVGAPlayer.h"

@class RACSignal;
NS_ASSUME_NONNULL_BEGIN

@interface UIGeneralSVGAAnimationView : UICommonView
@property(nonatomic, strong, readonly)TPTSVGAPlayer * appGiftPlayer;
+ (instancetype)svgaAnimationViewFrame:(CGRect)frame
                          svgaDelegate:(id<SVGAPlayerDelegate> __nullable)delegate;


- (RACSignal *)startAnimationInResultSignalWithFilePath:(NSString *)filePath;

- (void)setupMute:(BOOL)mute;
- (void)pausePlayer;
- (void)unInitPlayer;
@end

NS_ASSUME_NONNULL_END
