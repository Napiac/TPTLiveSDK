//
//  UICommonCollectionItem.h
//  TPTCoreMoudle
//
//  Created by Napiac on 2022/7/21.
//  Copyright © 2022 Napiac. All rights reserved.
//

///基础类
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICommonCollectionItem : UICollectionViewCell 
@property(nonatomic, strong)id entity;

- (void)parseEntity:(id)entity;
+ (instancetype)loadItemWithCollectionView:(UICollectionView *)collectionView
                                 indexPath:(NSIndexPath *)indexPath;
+ (instancetype)loadNibItemWithCollectionView:(UICollectionView *)collectionView
                                    indexPath:(NSIndexPath *)indexPath
                                          nib:(UINib *)iNib;
@end

NS_ASSUME_NONNULL_END
