//
//  NSObject+Object.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/20.
//  Copyright © 2022 Napiac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserIconConfigure : NSObject
/// 性别
@property(nonatomic, copy)NSString * gender;

@end















@interface NSObject (Object)

/// 加载NSBundle
/// @param bundleName bundle名字
/// @param inMoudleClassName 在模块里的Class
NSBundle * _Nullable LoadBundle(NSString * bundleName,
                                NSString * inMoudleClassName);


/// 加载资源
/// @param resourceName 资源名字
/// @param bundleName bundle名字
/// @param suffix 资源后缀
/// @param inMoudleClassName 在模块里的Class
NSData * _Nullable LoadResource(NSString * resourceName,
                                NSString * bundleName,
                                NSString * suffix,
                                NSString * inMoudleClassName);



/// 通过NIB初始化View 使用方法：[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil]
/// @param bundleName bundle名字
/// @param viewName View/Nib名字
/// @param inMoudleClassName 在模块里的Class
NSArray * _Nullable LoadViewWithNib(NSString * bundleName,
                                    NSString * viewName,
                                    NSString * inMoudleClassName);



/// 获取NIB 使用方法：[UINib nibWithNibName:NSStringFromClass(self.class) bundle:bundle]
/// @param bundleName bundle名字
/// @param nibName nib名字
/// @param inMoudleClassName 在模块里的Class
UINib * _Nullable LoadNib(NSString * bundleName,
                          NSString * nibName,
                          NSString * inMoudleClassName);


/// 获取用户icon
/// @param config UserIconConfigure
- (__kindof NSObject *)fetchUserIconsWithConfigure:(UserIconConfigure *)config;


/// 手机震动
- (void)mobileVibrate;
@end

NS_ASSUME_NONNULL_END
