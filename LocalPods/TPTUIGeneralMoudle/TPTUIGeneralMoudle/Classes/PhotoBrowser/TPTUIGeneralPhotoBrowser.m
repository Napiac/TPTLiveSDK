//
//  TPTUIGeneralPhotoBrowser.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import "TPTUIGeneralPhotoBrowser.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import <SDWebImage/SDWebImage.h>
#import <AVKit/AVKit.h>
#import "NSObject+FastAlert.h"
#import <Photos/Photos.h>

@interface TPTUIGeneralPhotoItem : UICollectionViewCell
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)AVPlayerLayer *playerLayer;

@end


@implementation TPTUIGeneralPhotoItem
- (void)dealloc {
    [self uninitPlayer];
}

- (void)uninitPlayer {
    [_player pause];
    _playerLayer.player = nil;
    [_playerLayer removeFromSuperlayer];
    _player = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        @weakify(self);
        [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            if ([(AVPlayerItem *)[x object] isEqual:self.player.currentItem]){
                [self.player seekToTime:kCMTimeZero];
                [self.player play];
            }
        }];
    }
    return self;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (void)didMoveToSuperview {
    if (!self.superview) {
        [self uninitPlayer];
    }
}

@end
@interface TPTUIGeneralPhotoBrowserBar : UICommonView
@property(nonatomic, strong)NSMutableArray <UICommonView *> * dataSource;
@property(nonatomic, assign)NSUInteger maxProgress;
@property(nonatomic, assign)NSUInteger currentProgress;
@property(nonatomic, strong)UIButton *closeButton;
@end

@implementation TPTUIGeneralPhotoBrowserBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializationUserInterface];
    }
    return self;
}

- (void)initializationUserInterface {
    /// 因为最多只有9张图片
    self.dataSource = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i<9; i++) {
        UICommonView * progressView = [[UICommonView alloc] init];
        progressView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
        progressView.hidden = YES;
        [progressView cornerRadius:1.5f];
        [self addSubview:progressView];
        [self.dataSource addObject:progressView];
    }
}

- (void)setMaxProgress:(NSUInteger)maxProgress {
    _maxProgress = maxProgress;
    if (maxProgress >= self.dataSource.count) {
        self.hidden = YES;
        return;
    }
    for (NSUInteger i = 0; i<self.dataSource.count; i++) {
        BOOL condition = (i>=maxProgress);
        UICommonView * progressView = self.dataSource[i];
        progressView.hidden = condition;
        if (condition) {
            continue;
        }
        CGFloat diff = 4.f;
        CGFloat width = (self.width - (maxProgress-1)*diff)/maxProgress;
        progressView.frame = CGRectMake(i*(diff+width), 0, width, self.height);
    
    }
}

- (void)setCurrentProgress:(NSUInteger)currentProgress {
    _currentProgress = currentProgress;
    if (currentProgress >= self.dataSource.count) {
        return;
    }
    if (currentProgress > self.maxProgress) {
        return;
    }
    for (NSUInteger i = 0; i<self.maxProgress; i++) {
        UICommonView * progressView = self.dataSource[i];
        progressView.hidden = NO;
        if (i<=currentProgress) {
            progressView.backgroundColor = [UIColor whiteColor];
        } else {
            progressView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2f];
        }
    }
}

@end






@interface TPTUIGeneralPhotoBrowser ()<SDCycleScrollViewDelegate>
@property(nonatomic, strong)NSArray <NSString *> * photoURLPaths;
@property(nonatomic, strong)SDCycleScrollView * browserView;
@property(nonatomic, strong)TPTUIGeneralPhotoBrowserBar * progressBar;
@property(nonatomic, strong)UILongPressGestureRecognizer * longPressGesture;
/// 浏览类型 0 图片 1视频
@property(nonatomic, assign)int browserType;
@end

@implementation TPTUIGeneralPhotoBrowser

+ (instancetype)browserWithPhotos:(NSArray <NSString *> *)photoURLPaths
                     currentIndex:(NSInteger)currentIndex {
    CGRect frame = CGRectMake(0.f, 0.f, kScreenW, kScreenH);
    TPTUIGeneralPhotoBrowser * photoBrowser = [[TPTUIGeneralPhotoBrowser alloc] initWithFrame:frame];
    photoBrowser.photoURLPaths = photoURLPaths;
    photoBrowser.progressBar.currentProgress = currentIndex;
    @weakify(photoBrowser);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        @strongify(photoBrowser);
        [photoBrowser.browserView makeScrollViewScrollToIndex:currentIndex];
    }];
    return photoBrowser;
}
+ (instancetype)browserWithVideos:(NSArray <NSString *> *)videoURLPaths
                     currentIndex:(NSInteger)currentIndex {
    CGRect frame = CGRectMake(0.f, 0.f, kScreenW, kScreenH);
    TPTUIGeneralPhotoBrowser * photoBrowser = [[TPTUIGeneralPhotoBrowser alloc] initWithFrame:frame];
    photoBrowser.photoURLPaths = videoURLPaths;
    photoBrowser.progressBar.currentProgress = currentIndex;
    photoBrowser.browserType = 1;
    photoBrowser.browserView.autoScroll = NO;
    photoBrowser.browserView.infiniteLoop = NO;
    @weakify(photoBrowser);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        @strongify(photoBrowser);
        [photoBrowser.browserView makeScrollViewScrollToIndex:currentIndex];
//        @weakify(photoBrowser);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            @strongify(photoBrowser);
            [photoBrowser stopAllVideo];
            [photoBrowser playVideoWithIndex:currentIndex];
        });
    }];
    return photoBrowser;
}
- (void)dealloc {
    _photoURLPaths = nil;
}
- (void)removeFromSuperview {
    [super removeFromSuperview];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.pageControlBottomPadding = 60;
        self.showPageControl = YES;
        [self initializationUserInterface];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.browserView.frame = self.bounds;
    self.progressBar.frame = CGRectMake(16.f, self.height-self.pageControlBottomPadding, self.height-32.f, 3.f);
}

- (void)initializationUserInterface {
    [self addSubview:self.browserView];
    [self addSubview:self.progressBar];
    
    self.longPressGesture = [[UILongPressGestureRecognizer alloc] init];
    self.longPressGesture.minimumPressDuration = 1.f;
    [self.browserView addGestureRecognizer:self.longPressGesture];
    @weakify(self);
    [[self.longPressGesture rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        UIGeneralAlertAction * cancel = [UIGeneralAlertAction actionWithTitleObjc:@"取消"];
        UIGeneralAlertAction * downloadAction = [UIGeneralAlertAction actionWithTitleObjc:@"保存到相册"
                                                                                  handler:^(UIGeneralAlertAction * _Nullable action) {
            @strongify(self);
            [self saveImageToPhotosAlbum];
        }];
        @strongify(self);
        [self popupAlertWithStyle:AlertStyle_Sheet
                       alertTitle:@"请选择"
                     alertMessage:nil
                     alertActions:@[downloadAction,cancel]];
        
        
    }];
}

- (void)saveImageToPhotosAlbum {
    NSURL * URL = [NSURL URLWithString:self.browserView.imageURLStringsGroup[self.progressBar.currentProgress]];
    if (self.browserType == 0) {
        SDImageCache * cache = [SDImageCache sharedImageCache];
        if (![cache diskImageDataExistsWithKey:URL.absoluteString]) {
            [[SDWebImageManager sharedManager] loadImageWithURL:URL
                                                        options:SDWebImageContinueInBackground
                                                       progress:nil
                                                      completed:^(UIImage * image,
                                                                  NSData * data,
                                                                  NSError * error,
                                                                  SDImageCacheType
                                                                  cacheType,
                                                                  BOOL finished,
                                                                  NSURL * imageURL) {
                if (!image) {
                    return;
                }
                [NSObject showToast:@"保存成功"];
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
            }];
            return;
        }
        UIImage * image = [cache imageFromDiskCacheForKey:URL.absoluteString];
        if (!image) {
            return;
        }
        [NSObject showToast:@"保存成功"];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    }
    
    if (self.browserType == 1) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error){
                    NSLog(@"视频下载失败：%@",error);
                }else{
                    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
                    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
                    [photoLibrary performChanges:^{
                            [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL
                                                                                                fileURLWithPath:fullPath]];
                    } completionHandler:^(BOOL success, NSError * _Nullable error) {
                        if (success) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [NSObject showToast:@"保存成功"];
                            }];
                            [[NSFileManager defaultManager] removeItemAtPath:fullPath
                                                                              error:nil];
                        } else {
                            NSLog(@"未能保存视频到相册");
                        }
                    }];
                }
            }];
            [downloadTask resume];
        });
    }
}

- (void)runStyle {
    self.progressBar.hidden = !self.showPageControl;
}

#pragma mark -
#pragma mark - SDCycleScrollViewDelegate

/// 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    self.itemClickBlock?self.itemClickBlock(index):nil;
}
 
/// 图片滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.progressBar.currentProgress = index;
    [self stopAllVideo];
    if (self.browserType == 1) {
        [self playVideoWithIndex:index];
    }
}

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return [TPTUIGeneralPhotoItem class];
}


/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(TPTUIGeneralPhotoItem *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    NSString *url = self.photoURLPaths[index];
    if (self.browserType == 1) {
        [cell.playerLayer removeFromSuperlayer];
        cell.tag = 100+index;
        cell.player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
        cell.playerLayer = [AVPlayerLayer playerLayerWithPlayer:cell.player];
        cell.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [cell.contentView.layer addSublayer:cell.playerLayer];
        cell.playerLayer.frame = cell.contentView.bounds;
        [cell.player pause];
        [self willBindRacEvent];
        @weakify(self);
        @weakify(cell);
        [[[self rac_signalForSelector:@selector(stopAllVideo)]
          takeUntil:[self rac_signalForSelector:@selector(willBindRacEvent)]]
         subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            @strongify(cell);
            [cell.player pause];
        }];
        [[[self.rac_willDeallocSignal merge:[self rac_signalForSelector:@selector(removeFromSuperview)]]
          takeUntil:[self rac_signalForSelector:@selector(willBindRacEvent)]] subscribeNext:^(id  _Nullable x) {
            @strongify(cell);
            [cell uninitPlayer];
        }];
        [[[self rac_signalForSelector:@selector(playVideoWithIndex:)]
          takeUntil:[self rac_signalForSelector:@selector(willBindRacEvent)]]
         subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            @strongify(cell);
            if (cell.tag == 100+[x.first integerValue]) {
                [cell.player play];
            }
        }];
    } else {
        [cell.playerLayer removeFromSuperlayer];
        cell.imageView.hidden = NO;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:view.placeholderImage];
    }
}


- (void)willBindRacEvent {}

- (void)stopAllVideo {}

- (void)playVideoWithIndex:(NSInteger)index {}

#pragma mark -
#pragma mark - Set / Get

- (void)setPhotoURLPaths:(NSArray<NSString *> *)photoURLPaths {
    _photoURLPaths = photoURLPaths;
    self.browserView.imageURLStringsGroup = photoURLPaths;
    self.progressBar.maxProgress = photoURLPaths.count;
    self.progressBar.currentProgress = 0;
}

- (void)setSupportAutoScroll:(BOOL)supportAutoScroll {
    _supportAutoScroll = supportAutoScroll;
    self.browserView.autoScroll = supportAutoScroll;
}

- (void)setSupportDownload:(BOOL)supportDownload {
    _supportDownload = supportDownload;
    self.longPressGesture.enabled = supportDownload;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    _showPageControl = showPageControl;
    if (self.progressBar.hidden == !showPageControl) {
        return;
    }
    if (!showPageControl) {
        self.progressBar.hidden = YES;
        return;
    }
    [self performSelector:@selector(runStyle) withObject:nil afterDelay:0.5f];
}

#pragma mark -
#pragma mark - Lazy Init

- (SDCycleScrollView *)browserView {
    if (!_browserView) {
        _browserView = ({
            SDCycleScrollView * cyClesScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds delegate:self placeholderImage:nil];
            cyClesScrollView.delegate = self;
            cyClesScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            cyClesScrollView.autoScrollTimeInterval = 5;
            cyClesScrollView.infiniteLoop = YES;
            cyClesScrollView.showPageControl = NO;
            cyClesScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
            cyClesScrollView.backgroundColor = [UIColor clearColor];
            cyClesScrollView.clipsToBounds = YES;
            cyClesScrollView;
        });
    }
    return _browserView;
}

- (TPTUIGeneralPhotoBrowserBar *)progressBar {
    if (!_progressBar) {
        CGRect frame = CGRectMake(16.f, self.height-60.f, self.width-32.f, 3.f);
        _progressBar = [[TPTUIGeneralPhotoBrowserBar alloc] initWithFrame:frame];
        _progressBar.hidden = YES;
    }
    return _progressBar;
}
@end
