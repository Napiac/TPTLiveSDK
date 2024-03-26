//
//  NSObject+FastAlert.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import <Foundation/Foundation.h>
#import "UIGeneralAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FastAlert)



/// 一个按键的Alert
- (void)popupDefaultAlertWithTitle:(NSString * _Nullable)title
                           message:(NSString * _Nullable)message
                        actionText:(id)actionText
                           handler:(void (^) (UIGeneralAlertAction * action))handler;


/// 两个按钮的Alert
- (void)popupDefaultAlertWithTitle:(NSString * _Nullable)title
                           message:(NSString * _Nullable)message
                        actionText:(id)actionText
                   otherActionText:(id)otherActionText
                     actionHandler:(void (^) (UIGeneralAlertAction * action))actionHandler
                otherActionHandler:(void (^) (UIGeneralAlertAction * action))otherActionHandler;


/// 多个按钮的Alert
- (void)popupAlertWithStyle:(AlertStyle)style
                 alertTitle:(NSString * _Nullable)title
               alertMessage:(NSString * _Nullable)message
               alertActions:(NSArray <UIGeneralAlertAction *> *)actions;



@end

NS_ASSUME_NONNULL_END
