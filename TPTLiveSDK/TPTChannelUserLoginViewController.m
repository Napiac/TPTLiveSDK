//
//  TPTChannelUserLoginViewController.m
//  TPTLiveSDK_Example
//
//  Created by Napiac on 2024/4/23.
//  Copyright © 2024 Napiac. All rights reserved.
//

#import "TPTChannelUserLoginViewController.h"
#import <TPTLiveBusinessMoudle/TPTLiveFramework.h>
#import <TPTCoreMoudle/UIView+Lock.h>

@interface TPTChannelUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameInputTF;
@property (weak, nonatomic) IBOutlet UITextField *avatarInputTF;
@property (weak, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (weak, nonatomic) IBOutlet UILabel *genderText;
@property(nonatomic, assign)BOOL gender;

@end

@implementation TPTChannelUserLoginViewController

- (BOOL)navigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Channel User Login";
    self.view.backgroundColor = [UIColor colorWithHexString:@"333333"];
    
    self.idInputTF.attributedPlaceholder = [self placeholderStyleText:@"渠道侧用户Id"];
    self.nickNameInputTF.attributedPlaceholder = [self placeholderStyleText:@"渠道侧用户昵称（可选）"];
    self.avatarInputTF.attributedPlaceholder = [self placeholderStyleText:@"渠道侧用户头像（可选）"];
    self.gender = NO;
    
    @weakify(self);
    [[[self.genderSwitch rac_newOnChannel] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self);
        self.gender = [x boolValue];
        self.genderText.text = self.gender ? @"男" : @"女";
    }];
}

- (IBAction)channelUserLoginClicked:(UIButton *)sender {
    TPTLiveFrameworkUserInParam * inParam = [TPTLiveFrameworkUserInParam new];
    inParam.partner_user_id = self.idInputTF.text;
    inParam.nick_name = self.nickNameInputTF.text;
    inParam.head_img = self.avatarInputTF.text;
    inParam.gender = self.gender;
    
    [self.view endEditing:YES];
    if (inParam.partner_user_id.length == 0) return;
    sender.isLock = YES;
    @weakify(self);
    @weakify(sender);
    [TPTLiveFrameworkUserEvent channelUserLogout];
    [TPTLiveFrameworkUserEvent channelUserLoginWithInParam:inParam
                                                   handler:^(TPTLiveFrameworkCode code, NSString * _Nullable message) {
        @strongify(self);
        @strongify(sender);
        sender.isLock = NO;
        self.complate ? self.complate(YES) : nil;
        if (code != SDKOKCode) {
            [NSObject showToast:message];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            [NSObject showToast:@"登录成功"];
        }
    }];
}


- (IBAction)channelUserLogOutClicked:(id)sender {
    if (![TPTLiveFrameworkBuilder canEnterRoom]) return;
    [TPTLiveFrameworkUserEvent channelUserLogout];
    self.complate ? self.complate(NO) : nil;
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSAttributedString *)placeholderStyleText:(NSString *)styleText {
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:styleText];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]}
                            range:NSMakeRange(0, styleText.length)];
    return attributedText;
}



@end
