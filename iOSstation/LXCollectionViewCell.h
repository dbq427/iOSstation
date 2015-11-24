//
//  LXCollectionViewCell.h
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LXCollectionItemModel;

@interface LXCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LXCollectionItemModel * itemModel;

+ (instancetype)collectionViewCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

@end
