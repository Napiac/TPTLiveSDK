//
//  CoreMacro.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#ifndef CoreMacro_h
#define CoreMacro_h

/// 图片Bundle名字
static NSString * _Nullable const kCoreImagesBundleName = @"TPTCoreMoudle_Images";
/// 资源Bundle名字
static NSString * _Nullable const kCoreResourceBundleName = @"TPTCoreMoudle_Resource";

/// 在Core模块中的ClassName
static NSString * _Nullable const kInCoreMoudleClassName = @"UICommonViewController";

/// AvenirNextCondensed-BoldItalic 字体名字
static NSString * _Nullable const kAvenirBoldItalicFontName = @"AvenirNextCondensed-BoldItalic";

/// 资源文件的解密密码
static NSString * _Nullable const kFileUnzipPassword = @"9jsJmx38dhs_82jdKS";

/// 指定选中TabBar某个Index通知
static NSString * _Nullable const kNotifier_Appoint_TabBar_Selected_Index = @"kNotifier_Appoint_TabBar_Selected_Index";

/// 内购成功后告诉H5的通知
static NSString * _Nullable const kH5_Use_IAP_Notifier_PurchaseSuccess = @"H5_Use_IAP_Notifier_PurchaseSuccess";

/// EaseOutModal  消失的通知
static NSString * _Nullable const kUICommonEaseOutModalDismissNotification = @"kUICommonEaseOutModalDismissNotification";

/// 首页视频继续播放 的通知
static NSString * _Nullable const kHomepageVideoKeepPlayNotification = @"kHomepageVideoKeepPlayNotification";

/// 进入语聊通话状态
static NSString * _Nullable const kNotifier_Generalws_BeganVoiceChat = @"kNotifier_Generalws_BeganVoiceChat";

/// 退出语聊通话状态
static NSString * _Nullable const kNotifier_Generalws_ExitVoiceChat = @"kNotifier_Generalws_ExitVoiceChat";

/// 启动广告展示完成通知
static NSString * _Nullable const kNotifier_AppIndependent_LaunchAdFinished = @"Notifier_AppIndependent_LaunchAdFinished";

/// 应用程序进程结束的通知
static NSString * _Nullable const kApplication_Process_End_Notification = @"Application_Process_End_Notification";

#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH ([[UIScreen mainScreen] bounds].size.height)

/// 判断是否是iPad
#define kDevice_Is_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

/// 判断设备是否存在安全区域
#define kDevice_Exist_SafeArea (([UIApplication sharedApplication].statusBarFrame.size.height > 20) && !kDevice_Is_iPad)



/// 屏幕比例
#define kScreenScale ([UIScreen mainScreen].bounds.size.width / 375)
/// 导航栏的高度
#define kSafeAreaTopHeight (kDevice_Exist_SafeArea ? 88 : 64)
/// 底部的高度
#define kSafeAreaBottomHeight (kDevice_Exist_SafeArea ? 34 : 0)
/// 状态栏的高度
#define kSafeAreaStatusHeight (kDevice_Exist_SafeArea ? 44 : 20)

#endif
