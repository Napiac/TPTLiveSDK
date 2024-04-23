//
//  TPTSVGAPlayer.h
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/10/14.
//

#import <SVGAPlayer/SVGAPlayer.h>
#import <SVGAPlayer/SVGA.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTSVGAPlayer : SVGAPlayer


/// 是否静音
@property(nonatomic, assign)BOOL mute;

/// 设置静音
/// - Parameter mute: 是否静音
- (void)setMute:(BOOL)mute;

@end

NS_ASSUME_NONNULL_END
