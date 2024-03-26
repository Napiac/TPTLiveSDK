//
//  TPTViewController.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 07/29/2022.
//  Copyright (c) 2022 Napiac. All rights reserved.
//

#import "TPTViewController.h"
#import <TPTUIGeneralMoudle/UIGeneralAlert.h>
#import <TPTUIGeneralMoudle/NSObject+FastAlert.h>
#import <TPTUIGeneralMoudle/TPTUIGeneralPhotoBrowserModal.h>
#import <TPTUIGeneralMoudle/TPTUIGeneralShareView.h>
#import <TPTUIGeneralMoudle/UIGeneralLoadingView.h>
#import <TPTUIGeneralMoudle/UIGeneralEmpty.h>
#import "UIGeneralMoreActionAlert.h"
#import <TPTUIGeneralMoudle/UIGeneralSVGAAnimationView.h>
#import <TPTUIGeneralMoudle/UIViewController+DrawerMenuController.h>

@interface TPTViewController ()
@property(nonatomic, strong)UIGeneralSVGAAnimationView *svgaPlayer;
@end

@implementation TPTViewController

- (NSString *)title {
    return @"首页";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    @weakify(self);
    UIButton * senderLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [senderLeft setTitle:@"打开左边" forState:UIControlStateNormal];
    senderLeft.backgroundColor = [UIColor randomColor];
    senderLeft.frame = CGRectMake(0.f, 100, self.view.width/2.f, 50.f);
    [[senderLeft rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        TPTUIGeneralShareFormItem * wechatItem = [TPTUIGeneralShareFormItem itemWithEnum:ShareEnum_WechatFriend];
        wechatItem.shareIcon = @"share_icon_wechat";
        wechatItem.shareTitle = @"垃圾好友";
        wechatItem.handler = ^{
            @strongify(self);
        };
        TPTUIGeneralShareView * shareView = [[TPTUIGeneralShareView alloc] initDefaultItems];
        [shareView showWithMaskView:nil];

    }];
    
    UIButton * sendRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendRight setTitle:@"打开右边" forState:UIControlStateNormal];
    sendRight.backgroundColor = [UIColor randomColor];
    sendRight.frame = CGRectMake(self.view.width/2.f, 100, self.view.width/2.f, 50.f);
    [[sendRight rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.drawerMenuController toggleDrawerSide:DrawerMenuSideRight
                                           animated:YES
                                         completion:^(BOOL finished) {
            
        }];
    }];
    [self.view addSubview:senderLeft];
    [self.view addSubview:sendRight];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    self.svgaPlayer = [UIGeneralSVGAAnimationView svgaAnimationViewFrame:self.view.bounds
                                                            svgaDelegate:nil];
    [[_svgaPlayer startAnimationInResultSignalWithFilePath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"svga"]] subscribeNext:^(id  _Nullable x) {
        
    }];
    [self.view addSubview:self.svgaPlayer];
    return;
    UIGeneralMoreActionAlert *modal = [UIGeneralMoreActionAlert.alloc initWithTitle:@"采蘑菇的小女孩"
                                                                     subTitle:@"ID：123456789"
                                                                        items:@[
        [UIGeneralMoreActionItemModel defalutShareItemModelWithHander:^(UIGeneralMoreActionItemModel * _Nonnull itemModel) {
            [[[TPTUIGeneralShareView alloc] initDefaultItems] showWithMaskView:self.view];
        }],
        [UIGeneralMoreActionItemModel defalutReportItemModelWithHander:^(UIGeneralMoreActionItemModel * _Nonnull itemModel) {
        
        }],
        [UIGeneralMoreActionItemModel defalutBlackItemModelWithHander:^(UIGeneralMoreActionItemModel * _Nonnull itemModel) {
        
        }]
    ]];
    [modal showInView:self.view];

    return;
    
    [self.view hideEmptyView];
    return;
    [[UIGeneralLoadingView showLoadingInView:self.view] removeAfterDuration:10];
    return;
    
//    NSArray * photos = @[@"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic%2F00%2F2c%2F16%2F002c16a48a88cdb75077d9d1abbf600d.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662978212&t=c0af3bc540a2ffaf2bf32987a1c5906d",
//                         @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.3dmgame.com%2Fuploads%2Fimages%2Fnews%2F20210224%2F1614152247_478025.jpg&refer=http%3A%2F%2Fimg.3dmgame.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662978212&t=d07e60d741694813c2d58f01bc4fd7df",
//                         @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F45%2Ffa%2Fb7%2F45fab71282dae578be117d2cb4e76eb1.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1662978212&t=4a1d25d808cbaf889d655b3b93e69a9f"];
//    TPTUIGeneralPhotoBrowserModal * modal = [TPTUIGeneralPhotoBrowserModal modalWithPhotos:photos currentIndex:1];
//    [modal showFrom:UICommonModalFromTop];
//
//    return;
//    TPTUIGeneralShareView * shareView = [[TPTUIGeneralShareView alloc] initDefaultItems];
//    [shareView showWithMaskView:self.view];
//
//    return;
//    UIGeneralAlertAction * confirmAction = [UIGeneralAlertAction actionWithTitleObjc:@"确认"
//                                                                             handler:^(UIGeneralAlertAction * _Nullable action) {
//        NSLog(@"x");
//    }];
//    [self popupAlertWithStyle:AlertStyle_Sheet
//                   alertTitle:@"LOL季前赛预告"
//                 alertMessage:@"设计师向玩家介绍明年的玩法计划，新版龙王技能公布，妮蔻辛德拉面临重做，炼金龙回归，让我们来了解一下！"
//                 alertActions:@[confirmAction,confirmAction,confirmAction]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
