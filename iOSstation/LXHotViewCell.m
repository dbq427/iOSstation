//
//  LXHotViewCell.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/25.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXHotViewCell.h"
#import "LXHotCellModel.h"
#import "UIImageView+WebCache.h"

@interface LXHotViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation LXHotViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(LXHotCellModel *)cellModel {
    _cellModel = cellModel;
    
    self.titleLabel.text = cellModel.title;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:cellModel.imageUrlStr]];
}

@end
