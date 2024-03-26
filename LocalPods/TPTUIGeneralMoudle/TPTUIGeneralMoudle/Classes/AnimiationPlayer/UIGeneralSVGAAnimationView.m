//
//  UIGeneralSVGAAnimationView.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//

#import "UIGeneralSVGAAnimationView.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@interface UIGeneralSVGAAnimationView ()<SVGAPlayerDelegate>
@property(nonatomic, strong)TPTSVGAPlayer * appGiftPlayer;
@property(nonatomic, strong)SVGAParser * appParser;
@property(nonatomic, weak)id svgaPlayerDelegate;

@property(nonatomic, assign)BOOL isMute;
@end

@implementation UIGeneralSVGAAnimationView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializationUserInterface];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializationUserInterface];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initializationUserInterface];
    }
    return self;
}

+ (instancetype)svgaAnimationViewFrame:(CGRect)frame
                          svgaDelegate:(id<SVGAPlayerDelegate> __nullable)delegate {
    UIGeneralSVGAAnimationView * animationView = [[UIGeneralSVGAAnimationView alloc] initWithFrame:frame];
    if (animationView) {
        animationView.svgaPlayerDelegate = delegate;
        animationView.appGiftPlayer.delegate = animationView.svgaPlayerDelegate ? animationView.svgaPlayerDelegate : animationView;
    }
    return animationView;
}

- (RACSignal *)startAnimationInResultSignalWithFilePath:(NSString *)filePath {
    NSData * fileData = [NSData dataWithContentsOfFile:filePath];
    if (fileData.length <= 0) {
        return [RACSignal error:[self error]];
    }
    
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if (!self.appParser) {
            [self createSVGAParser];
        }
        [self.appParser parseWithData:fileData
                             cacheKey:filePath
                      completionBlock:^(SVGAVideoEntity * videoItem) {
            @strongify(self);
            if (videoItem) {
                if (!self.appGiftPlayer) {
                    [self createSVGAPlayer];
                }
                [self.appGiftPlayer setVideoItem:videoItem];
                [self.appGiftPlayer startAnimation];
                [[self rac_signalForSelector:@selector(svgaPlayerDidFinishedAnimation:)] subscribeNext:^(RACTuple * x) {
                    [subscriber sendNext:x];
                    [subscriber sendCompleted];
                }];
            } else {
                [subscriber sendError:[self notSuppertError]];
                [subscriber sendCompleted];
            }
        } failureBlock:^(NSError * error) {
            @strongify(self);
            [subscriber sendError:[self parserError]];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)setupMute:(BOOL)mute{
    _isMute = mute;
    [self.appGiftPlayer setMute:mute];
}

- (void)pausePlayer {
    if (_appGiftPlayer) {
        [_appGiftPlayer stopAnimation];
        [_appGiftPlayer clear];
        [_appGiftPlayer clearDynamicObjects];
        _appGiftPlayer.videoItem = nil;
    }
}


- (void)unInitPlayer {
    if (_appGiftPlayer) {
        [self pausePlayer];
        [_appGiftPlayer removeFromSuperview];
        _appGiftPlayer = nil;
    }
    if (_appParser) {
        _appParser = nil;
    }
}

- (void)initializationUserInterface {
    [self createSVGAPlayer];
    [self createSVGAParser];
}

- (void)createSVGAPlayer {
    self.appGiftPlayer = [[TPTSVGAPlayer alloc] init];
    self.appGiftPlayer.frame = self.bounds;
    self.appGiftPlayer.userInteractionEnabled = NO;
    self.appGiftPlayer.contentMode = UIViewContentModeScaleAspectFit;
    self.appGiftPlayer.loops = 1;
    self.appGiftPlayer.delegate = self;
    self.appGiftPlayer.clearsAfterStop = YES;
    [self addSubview:self.appGiftPlayer];
}

- (void)createSVGAParser {
    self.appParser = [[SVGAParser alloc] init];
}

#pragma mark -
#pragma mark - Error

- (NSError *)error {
    return [NSError errorWithDomain:[NSBundle bundleForClass:self.class].bundleIdentifier
                               code:-100001
                           userInfo:@{NSLocalizedDescriptionKey:@"ERROR"}];
}

- (NSError *)parserError {
    return [NSError errorWithDomain:[NSBundle bundleForClass:self.class].bundleIdentifier
                               code:-100001
                           userInfo:@{NSLocalizedDescriptionKey:@"PARSER ERROR"}];
}


- (NSError *)notSuppertError {
    return [NSError errorWithDomain:[NSBundle bundleForClass:self.class].bundleIdentifier
                               code:-100001
                           userInfo:@{NSLocalizedDescriptionKey:@"NOT SUPPERT ERROR:NOT VIDEOITEM"}];
}

#pragma mark -
#pragma mark - SVGAPlayerDelegate

- (void)svgaPlayerDidFinishedAnimation:(SVGAPlayer *)player {
    
}

- (void)svgaPlayer:(TPTSVGAPlayer *)player didAnimatedToFrame:(NSInteger)frame{
}

- (void)svgaPlayer:(TPTSVGAPlayer *)player didAnimatedToPercentage:(CGFloat)percentage{
    
}
@end
