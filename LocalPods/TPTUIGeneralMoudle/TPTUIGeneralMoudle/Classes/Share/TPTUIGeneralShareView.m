//
//  TPTUIGeneralShareView.m
//  FDFullscreenPopGesture
//
//  Created by Napiac on 2022/8/13.
//

#import "TPTUIGeneralShareView.h"

#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import <TPTCoreMoudle/NSString+Base64.h>
#import <TPTCoreMoudle/UICommonEaseOutModal.h>
#import <TPTCoreMoudle/UIImage+Compress.h>

#import "UIGeneralRouterSend.h"
#import "TPTUIGeneralMoudle.h"

@implementation TPTUIGeneralShareInfo
@end










@interface TPTUIGeneralShareView ()
@property(nonatomic, strong)NSArray <TPTUIGeneralShareFormItem *> * dataSource;
@property(nonatomic, strong)TPTUIGeneralShareInfo *shareInfo;
@end

@implementation TPTUIGeneralShareView

- (instancetype)initDefaultItems {
    return [self initDefaultItemsWithCompletion:nil];
}

- (instancetype)initDefaultItemsWithCompletion:(ShareCompletion _Nullable)completion {
    return [self initWithItems:nil shareComplateion:completion];
}

- (instancetype)initWithItems:(NSArray <TPTUIGeneralShareFormItem *> * _Nullable)items
             shareComplateion:(ShareCompletion _Nullable)completion {
    self = [super init];
    if (self) {
        if (items.count == 0) {
            items = [self defaultItems];
        }
        self.frame = CGRectMake(0.f, 0.f, kScreenW, 160+kSafeAreaBottomHeight);
        self.dataSource = items;
        self.shareCompletion = completion;
        [self initializationUserInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight radius:24.f];
}

- (void)initializationUserInterface {
    UILabel * titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.frame = CGRectMake(0, 16.f, self.width, 24);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"分享";
    [self addSubview:titleLabel];
    
    CGFloat diff = 29;
    self.backgroundColor = [UIColor colorWithHexString:@"#141419"];
    for (int i = 0; i<self.dataSource.count; i++) {
        TPTUIGeneralShareFormItem * formItem = self.dataSource[i];
        
        UIControl * itemUIControl = [UIControl new];
        itemUIControl.frame = CGRectMake(16.f+i*55+i*diff, 63, 55, 70.f);
        itemUIControl.tag = 101+i;
        
        UIView *imageBackgroundView = [UIView new];
        imageBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#1D1C1D"];
        imageBackgroundView.frame = CGRectMake(0, 0, 55, 55);
        [imageBackgroundView cornerRadius:55/2.f];
        imageBackgroundView.layer.masksToBounds = YES;
        imageBackgroundView.userInteractionEnabled = NO;
        [itemUIControl addSubview:imageBackgroundView];
        
        UIImageView * iconImageView = [UIImageView new];
        iconImageView.image = UIGeneralBusinessBundleLoadImage(formItem.shareIcon);
        iconImageView.frame = CGRectMake(21/2.f, 21/2.f, 34, 34);
        [imageBackgroundView addSubview:iconImageView];
        
        UILabel * titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:11.f];
        titleLabel.textColor  = [UIColor colorWithHexString:@"#9F9F9F"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = formItem.shareTitle;
        titleLabel.frame = CGRectMake(0, CGRectGetMaxY(imageBackgroundView.frame)+7.f, itemUIControl.width, 15.f);
        [itemUIControl addSubview:titleLabel];
        
        [self addSubview:itemUIControl];
        @weakify(self);
        [[itemUIControl rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * x) {
            @strongify(self);
            self.dataSource[x.tag-101].handler ? self.dataSource[x.tag-101].handler() : nil;
        }];
    }
}

- (void)showWithMaskView:(UIView * _Nullable)view {
    UICommonEaseOutModal * modal = [UICommonEaseOutModal easeOut];
    [modal.contentView addSubview:self];
    modal.contentView.frame = CGRectMake(0.f, kScreenH, kScreenW, 160+kSafeAreaBottomHeight);
    modal.contentView.backgroundColor = [UIColor clearColor];
//    modal.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    if (!view) {
        [modal showFrom:UICommonModalFromTop];
        return;
    }
    [modal showFrom:UICommonModalFromTop inAddView:view];
}

/// 设置分享参数
/// @param title 标题
/// @param description 描述
/// @param img 图片
/// @param url 网址
- (void)setupShareInfoWithTitle:(NSString *)title
                    description:(NSString *)description
                       imgeIcon:(id)img
                        openUrl:(NSString *)url{
    TPTUIGeneralShareInfo *shareInfo = [[TPTUIGeneralShareInfo alloc] init];
    shareInfo.title = title;
    shareInfo.desc = description;
    shareInfo.img = img;
    shareInfo.url = url;
    self.shareInfo = shareInfo;
}

/// 设置分享参数
/// @param info obj
- (void)setupShareInfoWithObj:(TPTUIGeneralShareInfo *)info{
    self.shareInfo = info;
}

- (NSData *)getShareImageWithParam:(id)imageObject {
    UIImage * image = nil;
    if ([imageObject isKindOfClass:[NSString class]] &&
        ([imageObject hasPrefix:@"https://"] ||
         [imageObject hasPrefix:@"http://"])) {
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageObject]];
        image = [UIImage imageWithData:data];
    }
    if ([imageObject isKindOfClass:[UIImage class]]) {
        image = imageObject;
    }
    if (!imageObject) {
        image = [NSObject tpt_logo];
    }
    NSData * compressData =  [UIImage compressImage:image toMaxLength:(60 *1024) maxWidth:120];
    if (compressData.length/1024 > 64) {
        UIImage * iconImage = [NSObject tpt_logo];
        compressData = UIImageJPEGRepresentation(iconImage, 0.5f);
    }
    return compressData;
}

///朋友圈
- (void)shareToWechat {
    if (!self.shareInfo) {
        return;
    }
    UIGeneral_StartWechatShareWithParams(self.shareInfo.title,
                                         self.shareInfo.desc,
                                         self.shareInfo.url,
                                         1,
                                         [self getShareImageWithParam:self.shareInfo.img]);
    
    if (self.shareCompletion) self.shareCompletion(ShareEnum_Wechat);
}

///微信好友
- (void)shareToWechatFriend {
    if (!self.shareInfo) {
        return;
    }
    
    UIGeneral_StartWechatShareWithParams(self.shareInfo.title,
                                         self.shareInfo.desc,
                                         self.shareInfo.url,
                                         0,
                                         [self getShareImageWithParam:self.shareInfo.img]);
    
    if (self.shareCompletion) self.shareCompletion(ShareEnum_WechatFriend);
}


- (NSArray <TPTUIGeneralShareFormItem *> *)defaultItems {
    @weakify(self);
    TPTUIGeneralShareFormItem * wechatFriendItem = [TPTUIGeneralShareFormItem itemWithEnum:ShareEnum_WechatFriend];
    wechatFriendItem.shareIcon = @"share_icon_wechat";
    wechatFriendItem.shareTitle = @"微信好友";
    wechatFriendItem.handler = ^{
        @strongify(self);
        [self shareToWechatFriend];
    };
    
    TPTUIGeneralShareFormItem * wechatItem = [TPTUIGeneralShareFormItem itemWithEnum:ShareEnum_Wechat];
    wechatItem.shareIcon = @"share_icon_wechat_friend";
    wechatItem.shareTitle = @"朋友圈";
    wechatItem.handler = ^{
        @strongify(self);
        [self shareToWechat];
    };
    return @[wechatFriendItem,wechatItem];
}

@end

