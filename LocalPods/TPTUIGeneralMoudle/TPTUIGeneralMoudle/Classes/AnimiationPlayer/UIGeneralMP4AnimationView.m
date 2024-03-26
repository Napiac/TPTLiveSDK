//
//  UIGeneralMP4AnimationView.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/9.
//

#import "UIGeneralMP4AnimationView.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@interface UIGeneralMP4AnimationView () <VAPWrapViewDelegate>
@property(nonatomic, strong)QGVAPWrapView * vapWrapView;
@property(nonatomic, strong)id mp4DelegateTarget;

@end

@implementation UIGeneralMP4AnimationView

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

- (void)initializationUserInterface {
    self.vapWrapView = [[QGVAPWrapView alloc] initWithFrame:self.bounds];
    self.vapWrapView.backgroundColor = [UIColor clearColor];
    self.vapWrapView.contentMode = QGVAPWrapViewContentModeAspectFit;
    self.vapWrapView.autoDestoryAfterFinish = YES;
    [self addSubview:self.vapWrapView];
}

+ (instancetype)mp4AnimationViewFrame:(CGRect)frame
                         svgaDelegate:(id<VAPWrapViewDelegate>)delegate {
    UIGeneralMP4AnimationView * animationView = [[UIGeneralMP4AnimationView alloc] initWithFrame:frame];
    if (animationView) {
        animationView.mp4DelegateTarget = delegate;
    }
    return animationView;
}

- (RACSignal *)startAnimationInResultSignalWithFilePath:(NSString *)filePath {
    if (filePath.length == 0) {
        return [RACSignal error:[self error]];
    }
    if (!self.vapWrapView) {
        [self initializationUserInterface];
    }
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        id target = self.mp4DelegateTarget ? self.mp4DelegateTarget : self;
        [self.vapWrapView playHWDMP4:filePath
                         repeatCount:self.repeatMax
                            delegate:target];
        [[[self rac_signalForSelector:@selector(vapWrap_viewDidStopPlayMP4:view:)] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        [[[self rac_signalForSelector:@selector(vapWrap_viewDidFailPlayMP4:)] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple * x) {
            NSError * error = [NSError errorWithDomain:[NSBundle bundleForClass:self.class].bundleIdentifier
                                                  code:-100001
                                              userInfo:@{NSLocalizedDescriptionKey:x}];
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


- (void)pausePlayer {
    [self.vapWrapView pauseHWDMP4];
}

- (void)unInitPlayer {
    if (self.vapWrapView) {
        [self.vapWrapView stopHWDMP4];
        UIView * mp4EffectView = [self.vapWrapView valueForKey:@"vapView"];
        [mp4EffectView removeFromSuperview];
        mp4EffectView = nil;
        [self.vapWrapView removeFromSuperview];
        self.vapWrapView = nil;
    }
}

- (void)setupMute:(BOOL)mute{
    [self.vapWrapView setMute:mute];
}

- (NSError *)error {
    return [NSError errorWithDomain:[NSBundle bundleForClass:self.class].bundleIdentifier
                               code:-100001
                           userInfo:@{NSLocalizedDescriptionKey:@"ERROR"}];
}


#pragma mark -
#pragma mark - VAPWrapViewDelegate TODO:所有回调全在子线程中

- (BOOL)vapWrap_viewshouldStartPlayMP4:(VAPView *)container config:(QGVAPConfigModel *)config {
    return YES;
}

- (void)vapWrap_viewDidStartPlayMP4:(VAPView *)container {}
- (void)vapWrap_viewDidPlayMP4AtFrame:(QGMP4AnimatedImageFrame*)frame view:(VAPView *)container {}
- (void)vapWrap_viewDidFinishPlayMP4:(NSInteger)totalFrameCount view:(VAPView *)container {}

- (void)vapWrap_viewDidStopPlayMP4:(NSInteger)lastFrameIndex view:(VAPView *)container {}

- (void)vapWrap_viewDidFailPlayMP4:(NSError *)error {}
@end
