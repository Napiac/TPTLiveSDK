//
//  TPTSVGAPlayer.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/10/14.
//

#import "TPTSVGAPlayer.h"
#import <SVGAPlayer/SVGAAudioLayer.h>
#import <ReactiveObjC/ReactiveObjC.h>
@implementation TPTSVGAPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        [[[self rac_signalForSelector:@selector(setAudioLayers:)] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            for (SVGAAudioLayer *layer in x.first) {
                [layer.audioPlayer setVolume:self.mute?0:1];
            }
        }];
    }
    return self;
}

/// 设置静音
/// - Parameter mute: 是否静音
- (void)setMute:(BOOL)mute{
    _mute = mute;
    for (SVGAAudioLayer *layer in self.tpt_getAudioLayers) {
        [layer.audioPlayer setVolume:mute?0:1];
    }
}

- (NSArray <SVGAAudioLayer *>*)tpt_getAudioLayers{
    if([self respondsToSelector:@selector(audioLayers)]){
        return [self performSelector:@selector(audioLayers)];
    }
    return nil;
}

@end
