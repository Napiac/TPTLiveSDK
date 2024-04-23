//
//  TPTUIGeneralMoudle.h
//  TPTUIGeneralMoudle
//
//  Created by Napiac on 2022/7/29.
//

#ifndef TPTUIGeneralMoudle_h
#define TPTUIGeneralMoudle_h

#import <TPTCoreMoudle/UIImage+image.h>

/// Bundle名字
static NSString * _Nullable const kUIGeneralBusinessBundleName = @"TPTUIGeneralMoudle";

/// 模块里Class的名字
static NSString * _Nullable const kInUIGeneralBusinessMoudleClassName = @"TPTUIGeneralPhotoBrowser";


NS_INLINE UIImage * _Nullable UIGeneralBusinessBundleLoadImage(NSString * _Nullable imageName) {
    return LoadImage(imageName, kUIGeneralBusinessBundleName, kInUIGeneralBusinessMoudleClassName);
}

#endif /* TPTUIGeneralMoudle_h */
