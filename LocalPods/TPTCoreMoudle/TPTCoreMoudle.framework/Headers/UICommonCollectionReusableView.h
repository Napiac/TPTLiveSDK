//
//  UICommonCollectionReusableView.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

///基础类
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICommonCollectionReusableView : UICollectionReusableView

+ (instancetype)loadViewWithCollectionView:(UICollectionView *)collectionView
                                kindString:(NSString *)kind
                                 indexPath:(NSIndexPath *)indexPath;

+ (instancetype)loadNibViewWithCollectinoView:(UICollectionView *)collectionView
                                   kindString:(NSString *)kind
                                    indexPath:(NSIndexPath *)indexPath
                                          nib:(UINib *)iNib;
@end

NS_ASSUME_NONNULL_END
