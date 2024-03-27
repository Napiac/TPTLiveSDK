//
//  TPTViewController.m
//  TPTLiveSDK
//
//  Created by Napiac on 03/26/2024.
//  Copyright (c) 2024 Napiac. All rights reserved.
//

#import "TPTViewController.h"
#import <TPTLiveBusinessMoudle/TPTLiveFrameworkUserInParam.h>
#import <TPTLiveBusinessMoudle/TPTLiveFrameworkUserEvent.h>
#import <TPTLiveBusinessMoudle/TPTLiveFrameworkBuilder.h>
#import <TPTCoreMoudle/TPTCoreMoudle.h>

@interface TPTViewController ()
@property(nonatomic, strong)UITextField * userIdInputTF;
@end

@implementation TPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextField * userIdInputTF = [UITextField new];
    userIdInputTF.borderStyle = UITextBorderStyleNone;
    userIdInputTF.frame = CGRectMake(20, 200, kScreenW-40, 50);
    userIdInputTF.placeholder = @"输入渠道侧唯一标识";
    userIdInputTF.backgroundColor = [UIColor randomColor];
    [self.view addSubview:userIdInputTF];
    self.userIdInputTF = userIdInputTF;
    
    @weakify(self);
    UIButton * userLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userLoginButton.frame = CGRectMake(20, CGRectGetMaxY(userIdInputTF.frame)+20, kScreenW-40, 50);
    userLoginButton.backgroundColor = [UIColor randomColor];
    [userLoginButton setTitle:@"用户登录" forState:UIControlStateNormal];
    [[userLoginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSString * identifier = self.userIdInputTF.text;
        if (identifier.length == 0) {
            [NSObject showToast:@"先输入唯一标识"];
            return;
        }
        TPTLiveFrameworkUserInParam * userInParam = [TPTLiveFrameworkUserInParam new];
        userInParam.partner_user_id = identifier;
        [TPTLiveFrameworkUserEvent channelUserLoginWithInParam:userInParam
                                                       handler:^(BOOL success, NSString * _Nonnull message) {
            if (!success) {
                [NSObject showToast:message];
            } else {
                [NSObject showToast:@"登录成功"];
            }
        }];
    }];
    [self.view addSubview:userLoginButton];
    
    
    UIButton * userLogoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userLogoutButton.frame = CGRectMake(20, CGRectGetMaxY(userLoginButton.frame)+20, kScreenW-40, 50);
    userLogoutButton.backgroundColor = [UIColor randomColor];
    [userLogoutButton setTitle:@"用户退出" forState:UIControlStateNormal];
    [[userLogoutButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [TPTLiveFrameworkUserEvent channelUserLogout];
    }];
    [self.view addSubview:userLogoutButton];
    
    
    UIButton * toRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toRoomButton.frame = CGRectMake(20, CGRectGetMaxY(userLogoutButton.frame)+20, kScreenW-40, 50);
    toRoomButton.backgroundColor = [UIColor randomColor];
    [toRoomButton setTitle:@"进入直播间" forState:UIControlStateNormal];
    [[toRoomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![TPTLiveFrameworkBuilder canEnterRoom]) {
            [NSObject showToast:@"目前不能进直播间"];
            return;
        }
        [TPTLiveFrameworkBuilder enterRandomRoomWithParent:self
                                                 eventView:x];
    }];
    [self.view addSubview:toRoomButton];
}


@end
