//
//  NSObject+FastAlert.m
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/8/13.
//

#import "NSObject+FastAlert.h"

@implementation NSObject (FastAlert)

/// 一个按键的Alert
- (void)popupDefaultAlertWithTitle:(NSString * _Nullable)title
                           message:(NSString * _Nullable)message
                        actionText:(id)actionText
                           handler:(void (^) (UIGeneralAlertAction * action))handler {
    UIGeneralAlertAction * action = [UIGeneralAlertAction actionWithTitleObjc:actionText
                                                                      handler:handler];
    [self popupAlertWithStyle:AlertStyle_Default
                   alertTitle:title
                 alertMessage:message
                 alertActions:@[action]];
}


/// 两个按钮的Alert
- (void)popupDefaultAlertWithTitle:(NSString * _Nullable)title
                           message:(NSString * _Nullable)message
                        actionText:(id)actionText
                   otherActionText:(id)otherActionText
                     actionHandler:(void (^) (UIGeneralAlertAction * action))actionHandler
                otherActionHandler:(void (^) (UIGeneralAlertAction * action))otherActionHandler {
    
    UIGeneralAlertAction * action = [UIGeneralAlertAction actionWithTitleObjc:actionText
                                                                      handler:actionHandler];
    UIGeneralAlertAction * otherAction = [UIGeneralAlertAction actionWithTitleObjc:otherActionText
                                                                           handler:otherActionHandler];
    [self popupAlertWithStyle:AlertStyle_Default
                   alertTitle:title
                 alertMessage:message
                 alertActions:@[action,otherAction]];
}


/// 多个按钮的Alert
- (void)popupAlertWithStyle:(AlertStyle)style
                 alertTitle:(NSString * _Nullable)title
               alertMessage:(NSString * _Nullable)message
               alertActions:(NSArray <UIGeneralAlertAction *> *)actions {
    UIGeneralAlertController * alertController = [UIGeneralAlertController alertControllerWithStyle:style
                                                                                         alertTitle:title
                                                                                       alertMessage:message];
    [alertController addAlertActions:actions];
    [alertController showWithPresentController:nil];
}

@end
