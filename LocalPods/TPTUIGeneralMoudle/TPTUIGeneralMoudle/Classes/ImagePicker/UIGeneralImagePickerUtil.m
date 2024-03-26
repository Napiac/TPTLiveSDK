//
//  UIGeneralImagePickerUtil.m
//  TPTUIGeneralMoudle
//
//  Created by wangyin on 2022/9/5.
//


#import "UIGeneralImagePickerUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <TPTUIGeneralMoudle/NSObject+FastAlert.h>
#import <TPTCoreMoudle/UIColor+Color.h>
#import <TPTCoreMoudle/TPTCoreMoudle.h>
@interface UIGeneralImagePickerUtil () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) ImagePickerBlock imagePickerBlock;
@property (nonatomic, assign) BOOL allowEditing;
@property (nonatomic, weak) UIViewController *fromVC;

@end


@implementation UIGeneralImagePickerUtil

/**
 *  调用系统相机/相册
 *  @param allowEditing 是否允许编辑
 *  @param handler      选取图片后的回调
 */
- (void)pickImageEditing:(BOOL)allowEditing
                  fromVC:(UIViewController *)vc
                 handler:(ImagePickerBlock)handler {
    [self pickImageEditing:allowEditing
         insertPaddingView:nil
                    fromVC:vc
                   handler:handler];
}
/**
 *  调用系统相机/相册
 *  @param allowEditing 是否允许编辑
 *  @param paddingView 顶部paddingview
 *  @param handler      选取图片后的回调
 */
- (void)pickImageEditing:(BOOL)allowEditing
       insertPaddingView:(UIView *)paddingView
                  fromVC:(UIViewController *)vc
                 handler:(ImagePickerBlock)handler {
    self.allowEditing = allowEditing;
    self.imagePickerBlock = handler;
    self.fromVC = vc;
    
    __weak typeof(self) weakSelf = self;
    UIGeneralAlertAction *yiAlertAction = [UIGeneralAlertAction actionWithTitleObjc:[[NSAttributedString alloc] initWithString:@"拍照上传" attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#141416"],
        NSFontAttributeName : [UIFont boldSystemFontOfSize:16]
    }] handler:^(UIGeneralAlertAction * _Nullable action) {
        [weakSelf takePhotosWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIGeneralAlertAction *erAlertAction = [UIGeneralAlertAction actionWithTitleObjc:[[NSAttributedString alloc] initWithString:@"从相册选择" attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#141416"],
        NSFontAttributeName : [UIFont boldSystemFontOfSize:16]
    }] handler:^(UIGeneralAlertAction * _Nullable action) {
        [weakSelf takePhotosWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    yiAlertAction.buttonHeight = 59;
    erAlertAction.buttonHeight = 59;
    [self showMineGeneralAlertViewWithStyle:AlertStyle_Sheet paddingView:paddingView title:@"" message:@"" AlertActions:@[yiAlertAction, erAlertAction] fromVC:vc];
}

- (void)onCameraPickImageEditing:(BOOL)allowEditing fromVC:(UIViewController *)vc handler:(ImagePickerBlock)handler {
    self.allowEditing = allowEditing;
    self.imagePickerBlock = handler;
    [self takePhotosWithSourceType:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark -> 拍照/选取照片
- (void)takePhotosWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self authorizeWithCompletion:^(BOOL granted, BOOL firstTime) {
            if (granted) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = sourceType;
                picker.delegate = self;
                picker.allowsEditing = self.allowEditing;
                picker.modalPresentationStyle = UIModalPresentationFullScreen;
                __weak typeof(self) weakSelf = self;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [weakSelf.fromVC presentViewController:picker animated:YES completion:nil];
                });
            }
            else {
                UIGeneralAlertAction *yiAlertAction = [UIGeneralAlertAction actionWithTitleObjc:@"前往设置" handler:^(UIGeneralAlertAction * _Nullable action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                                       options:@{}
                                             completionHandler:nil];
                }];
                [self showMineGeneralAlertViewWithStyle:AlertStyle_Default paddingView:nil title:@"没有相机权限，请到设置-该app-相机里开启" message:@"" AlertActions:@[yiAlertAction] fromVC:self.fromVC];
            }
        }];
    }
    else {
        NSString *msg = nil;
        if (sourceType == UIImagePickerControllerSourceTypeCamera ) {//无摄像头
            msg = @"该设备摄像头不可用";
        } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {// 系统图库不可用
            msg = @"系统图库不可用";
        }
        UIGeneralAlertAction *yiAlertAction = [UIGeneralAlertAction actionWithTitleObjc:@"确定"];
        [self showMineGeneralAlertViewWithStyle:AlertStyle_Default paddingView:nil title:@"" message:msg AlertActions:@[yiAlertAction] fromVC:self.fromVC];
    }
}


#pragma mark -> UIImagePickerControllerDelegate
// 完成  拍照/选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    // 获取选中图片
    UIImage *image;
    if (picker.allowsEditing) {
        image =  [info objectForKey:UIImagePickerControllerEditedImage]; // 编辑后的图片
    } else {
        image = [info valueForKey:UIImagePickerControllerOriginalImage]; // 原图
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) { // 拍照后, 赋值的同时,把照片存到图片库
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil); // 把图片存到手机图片库
    }
    
    if (self.imagePickerBlock) {
        self.imagePickerBlock(image);
    }
    
    [self.fromVC dismissViewControllerAnimated:YES completion:^{}];
}

// 取消 拍照/选择图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self.fromVC dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark ->
- (void)authorizeWithCompletion:(void(^)(BOOL granted,BOOL firstTime))completion {
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)]) {
        AVAuthorizationStatus permission = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (permission) {
            case AVAuthorizationStatusAuthorized: {
                completion(YES, NO);
            } break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted: {
                completion(NO, NO);
            } break;
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (completion) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(granted,YES);
                        });
                    }
                }];
            } break;
        }
    }
    else {
        completion(YES, NO);
    }
}

- (void)showMineGeneralAlertViewWithStyle:(AlertStyle)style paddingView:(UIView *)paddingView title:(NSString *)title message:(NSString *)message AlertActions:(NSArray <UIGeneralAlertAction *> *)actions fromVC:(UIViewController *)vc  {
    NSMutableArray *alertActions = [NSMutableArray arrayWithArray:actions];
    
    NSMutableAttributedString *cancelString = [[NSMutableAttributedString alloc] initWithString:@"取消"];
    [cancelString addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#8D8D99"],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:16]
                                }
                          range:NSMakeRange(0, cancelString.length)];
    UIGeneralAlertAction *cancelAlertAction = [UIGeneralAlertAction actionWithTitleObjc:cancelString];
    cancelAlertAction.buttonHeight = 59 + kSafeAreaBottomHeight;
    cancelAlertAction.separatorLineHeight = 10;
    [alertActions insertObject:cancelAlertAction atIndex:alertActions.count];
    UIGeneralAlertController *alertController = [UIGeneralAlertController alertControllerWithStyle:style alertTitle:title alertMessage:message];
    [alertController insertTopPaddingView:paddingView];
    [alertController addAlertActions:alertActions];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [vc presentViewController:alertController animated:YES completion:^{}];
    });
}


@end
