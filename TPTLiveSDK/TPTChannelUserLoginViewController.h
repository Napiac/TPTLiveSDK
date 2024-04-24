//
//  TPTChannelUserLoginViewController.h
//  TPTLiveSDK_Example
//
//  Created by Napiac on 2024/4/23.
//  Copyright © 2024 Napiac. All rights reserved.
//

#import <TPTCoreMoudle/TPTCoreMoudle.h>

NS_ASSUME_NONNULL_BEGIN

@interface TPTChannelUserLoginViewController : UICommonViewController
@property (weak, nonatomic) IBOutlet UITextField *idInputTF;
@property(nonatomic, copy)void (^complate)(BOOL loginAct);
@end

NS_ASSUME_NONNULL_END
