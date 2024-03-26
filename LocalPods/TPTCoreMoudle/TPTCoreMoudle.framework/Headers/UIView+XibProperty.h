//
//  UIView+XibProperty.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2023/3/30.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (XibProperty)
/// APP主色调
@property(nonatomic, assign)IBInspectable BOOL appPrimaryColor;
/// APP背景颜色
@property(nonatomic, assign)IBInspectable BOOL appBackgroundColor;



/// 设置Hex颜色
@property(nonatomic, copy)IBInspectable NSString * appHexColor;
/// 设置圆角
@property(nonatomic, assign)IBInspectable CGFloat appViewRadius;



@end

NS_ASSUME_NONNULL_END
