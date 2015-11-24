//
//  LXProfileViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/24.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXProfileViewController.h"
#import "HMWaterflowView.h"
#import "LXWaterFlowViewModel.h"
#import "LXWaterFlowViewCell.h"

@interface LXProfileViewController () <HMWaterflowViewDataSource, HMWaterflowViewDelegate>

@property (weak, nonatomic) IBOutlet HMWaterflowView *waterFlowView;

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation LXProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.waterFlowView.dataSource = self;
    self.waterFlowView.delegate = self;
    
    NSArray * dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TestFile" ofType:@"plist"]];
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary * dict in dictArray) {
        LXWaterFlowViewModel * model = [LXWaterFlowViewModel waterFlowViewModelWithDict:dict];
        [dataArray addObject:model];
    }
    self.dataArray = dataArray;
    [self.waterFlowView reloadData];
    
}

#pragma mark - 数据源方法
- (NSUInteger)numberOfCellsInWaterflowView:(HMWaterflowView *)waterflowView
{
    return self.dataArray.count;
}

- (LXWaterFlowViewCell *)waterflowView:(HMWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    LXWaterFlowViewCell *cell = [LXWaterFlowViewCell cellWithWaterFlowView:waterflowView];
    
    cell.dataModel = self.dataArray[index];
    
    return cell;
}

- (NSUInteger)numberOfColumnsInWaterflowView:(HMWaterflowView *)waterflowView
{
    return 3;
}

#pragma mark - 代理方法
- (CGFloat)waterflowView:(HMWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    LXWaterFlowViewModel * data = self.dataArray[index];
    // 根据cell的宽度 和 图片的宽高比 算出 cell的高度
    return waterflowView.cellWidth * data.imageHeight / data.imageWidth;
}




@end
