//
//  LXCollectionViewCell.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "LXCollectionItemModel.h"

@interface LXCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;



@end

@implementation LXCollectionViewCell

+ (instancetype)collectionViewCellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    
    NSString * className = NSStringFromClass([self class]);
    
    UINib * nib = [UINib nibWithNibName:className bundle:nil];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:className];
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
    
}

- (void)setItemModel:(LXCollectionItemModel *)itemModel {
    
    _itemModel = itemModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:itemModel.imageUrlStr]];
}

@end
