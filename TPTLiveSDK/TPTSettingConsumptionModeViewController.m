//
//  TPTSettingConsumptionModeViewController.m
//  TPTLiveSDK_Example
//
//  Created by Napiac on 2024/4/23.
//  Copyright © 2024 Napiac. All rights reserved.
//

#import "TPTSettingConsumptionModeViewController.h"
#import <TPTHTTPRequestMoudle/HTTPClient+Fast.h>
#import <TPTManagerMoudle/UserManager.h>
#import <AFNetworking/AFNetworking.h>

@interface TPTSettingConsumptionModeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *idInputTF;
@property (weak, nonatomic) IBOutlet UITextField *settingBalanceInputTF;
@end

@implementation TPTSettingConsumptionModeViewController

- (BOOL)navigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Setting Consumption Mode";
    self.view.backgroundColor = [UIColor colorWithHexString:@"333333"];
    self.idInputTF.text = self.channelUserId;
    self.idInputTF.attributedPlaceholder = [self placeholderStyleText:@"渠道侧用户Id"];
    self.settingBalanceInputTF.attributedPlaceholder = [self placeholderStyleText:@"设置渠道侧用户余额"];
}

- (IBAction)settingBalanceClicked:(id)sender {
    if (self.settingBalanceInputTF.text.length == 0) return;
    NSDictionary * reqeustParam = @{@"user_id":self.idInputTF.text,
                                    @"balance":@(self.settingBalanceInputTF.text.integerValue)};
    AFHTTPSessionManager * reqeustSession = [AFHTTPSessionManager manager];
    reqeustSession.requestSerializer = [AFJSONRequestSerializer serializer];
    reqeustSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"application/x-json", @"text/html", @"text/plain", nil];
    @weakify(self);
    [reqeustSession POST:@"http://106.55.103.148:8006/api/user/changeBalance"
              parameters:reqeustParam
                 headers:nil
                progress:nil
                 success:^(NSURLSessionDataTask * task, id responseObject) {
        @strongify(self);
       [UserManager.shared.userInfo updateInfoWithKey:@"balance" value:self.settingBalanceInputTF.text];
        self.complate ? self.complate() : nil;
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [NSObject showToast:@"setting consumption mode http error"];
        NSLog(@"setting consumption mode http error:%@",error);
    }];
}

- (NSAttributedString *)placeholderStyleText:(NSString *)styleText {
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:styleText];
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"666666"]}
                            range:NSMakeRange(0, styleText.length)];
    return attributedText;
}



@end
