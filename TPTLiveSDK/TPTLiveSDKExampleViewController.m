//
//  TPTLiveSDKExampleViewController.m
//  TPTLiveSDK
//
//  Created by Napiac on 03/26/2024.
//  Copyright (c) 2024 Napiac. All rights reserved.
//

#import "TPTLiveSDKExampleViewController.h"
#import <TPTCoreMoudle/TPTCoreMoudle.h>
#import <TPTManagerMoudle/UserManager.h>
#import <TPTLiveBusinessMoudle/TPTLiveFramework.h>
#import <AFNetworking/AFNetworking.h>

#import "TPTAppDelegate.h"
#import "TPTChannelUserLoginViewController.h"
#import "TPTSettingConsumptionModeViewController.h"

@interface TPTLiveSDKExampleViewController ()
@property(nonatomic, strong)UILabel * currentUserLabel;
@property(nonatomic, strong)UITextField * userIdInputTF;


@property(nonatomic, assign)NSString * channelUserId;
@end

@implementation TPTLiveSDKExampleViewController

+ (NSString *)channelUserId {
    NSString * channerUserId = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass(self.class)];
    return channerUserId;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)navigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TPTLiveSDK Example";
    self.view.backgroundColor = [UIColor colorWithHexString:@"333333"];
    
    self.channelUserId = [TPTLiveSDKExampleViewController channelUserId];
    [self fetchConsumptionModeUserBalance];
    [self receiveConsumptionModeUserBalanceListener];
    
    UILabel * currentUserLabel = [UILabel new];
    self.currentUserLabel = currentUserLabel;
    currentUserLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    currentUserLabel.textColor = [UIColor whiteColor];
    currentUserLabel.numberOfLines = 0;
    [self.view addSubview:currentUserLabel];
    [currentUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kSafeAreaTopHeight);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
    }];
    [self setupUserDetailText];
    
    @weakify(self);
    UIButton * userLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userLoginButton.backgroundColor = [UIColor whiteColor];
    userLoginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [userLoginButton setTitle:@"渠道侧用户登录>>" forState:UIControlStateNormal];
    [userLoginButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.view addSubview:userLoginButton];
    [userLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(currentUserLabel);
        make.top.equalTo(currentUserLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    [[userLoginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        TPTChannelUserLoginViewController * channelUserLoginVc = [[TPTChannelUserLoginViewController alloc] init];
        [self.navigationController pushViewController:channelUserLoginVc animated:YES];
        @strongify(self);
        @weakify(channelUserLoginVc);
        channelUserLoginVc.complate = ^(BOOL loginAct) {
            @strongify(self);
            @strongify(channelUserLoginVc);
            if (loginAct) {
                self.channelUserId = channelUserLoginVc.idInputTF.text;
                [[TPTAppDelegate sharedAppDelegate] connectConsumptionModeListener];
                [[NSUserDefaults standardUserDefaults] setValue:self.channelUserId forKey:NSStringFromClass(self.class)];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } else {
                self.channelUserId = nil;
                [[TPTAppDelegate sharedAppDelegate] disconnectConsumptionModeListener];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass(self.class)];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [self setupUserDetailText];
        };
    }];
    
    UIButton * settingConsumptionModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingConsumptionModeButton.backgroundColor = [UIColor whiteColor];
    settingConsumptionModeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [settingConsumptionModeButton setTitle:@"代用户消费模式设置>>" forState:UIControlStateNormal];
    [settingConsumptionModeButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.view addSubview:settingConsumptionModeButton];
    [settingConsumptionModeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(userLoginButton);
        make.top.equalTo(userLoginButton.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    [[settingConsumptionModeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![TPTLiveFrameworkBuilder canEnterRoom]) {
            [NSObject showToast:@"请先登录"];
            return;
        }
        TPTSettingConsumptionModeViewController * settingConsumptionModeVc = [[TPTSettingConsumptionModeViewController alloc] init];
        settingConsumptionModeVc.channelUserId = self.channelUserId;
        [self.navigationController pushViewController:settingConsumptionModeVc animated:YES];
        settingConsumptionModeVc.complate = ^{
            @strongify(self);
            [self setupUserDetailText];
        };
    }];
    
    UIButton * toRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    toRoomButton.backgroundColor = [UIColor whiteColor];
    toRoomButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [toRoomButton setTitle:@"进入直播间" forState:UIControlStateNormal];
    [toRoomButton setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.view addSubview:toRoomButton];
    [toRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(userLoginButton);
        make.top.equalTo(settingConsumptionModeButton.mas_bottom).offset(20);
        make.height.mas_equalTo(50);
    }];
    [[toRoomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![TPTLiveFrameworkBuilder canEnterRoom]) return;
        [TPTLiveFrameworkBuilder enterRandomRoomWithParent:self
                                                 eventView:x
                                                    result:^(NSError * _Nullable error) {
            if (!error) return;
            if (error.code == SDKParamsErrorCode) {
                /// 参数错误
            }
            if (error.code == SDKUserLoginErrorCode) {
                /// 用户未登录，需重新登录
            }
            if (error.code == SDKEnterRoomErrorCode) {
                /// 进入房间请求错误
            }
        }];
    }];
 
}


- (void)setupUserDetailText {
    if ([TPTLiveFrameworkBuilder canEnterRoom]) {
        UserInfo * user = UserManager.shared.userInfo;
        self.currentUserLabel.text = [NSString stringWithFormat:@"当前用户Id：%@\n当前用户昵称：%@\n当前用户头像：%@\n当前用户余额：%@\n当前用户性别：%@",user.user_id,user.nick_name,user.head_portrait,user.balance,[user.gender boolValue] ? @"男" : @"女"];
    } else {
        self.currentUserLabel.text = @"用户未登录";
    }
}

#pragma mark -
#pragma mark - 代消费模式

- (void)fetchConsumptionModeUserBalance {
    @weakify(self);
    if (self.channelUserId.length == 0) return;
    NSDictionary * reqeustParam = @{@"user_id":self.channelUserId};
    AFHTTPSessionManager * reqeustSession = [AFHTTPSessionManager manager];
    reqeustSession.requestSerializer = [AFJSONRequestSerializer serializer];
    reqeustSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"application/x-json", @"text/html", @"text/plain", nil];
    [reqeustSession POST:@"http://106.55.103.148:8006/api/user/getBalance"
              parameters:reqeustParam
                 headers:nil
                progress:nil
                 success:^(NSURLSessionDataTask * task, id responseObject) {
        @strongify(self);
        if (![responseObject isKindOfClass:NSDictionary.class]) return;
        NSDictionary * response = (NSDictionary *)responseObject;
        if ([response[@"code"] integerValue] != 200) return;
        [UserManager.shared.userInfo updateInfoWithKey:@"balance" value:[NSString stringWithFormat:@"%@",response[@"data"][@"balance"]]];
        [self setupUserDetailText];
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [NSObject showToast:@"fetch consumption mode user balance error"];
        NSLog(@"fetch consumption mode user balance error:%@",error);
    }];
}

- (void)receiveConsumptionModeUserBalanceListener {
    @weakify(self);
    [[[[TPTAppDelegate.sharedAppDelegate rac_signalForSelector:@selector(postUpdateUserBalance)] throttle:1] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        [self fetchConsumptionModeUserBalance];
    }];
}

@end
