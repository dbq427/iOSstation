//
//  LXProfileViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#define Margin 10
#define Column 2

#import "LXProfileViewController.h"
#import "LXCollectionItemModel.h"
#import "LXCollectionViewCell.h"

@interface LXProfileViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation LXProfileViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    NSMutableArray * mArray = [[NSMutableArray alloc] init];
    NSArray * datas = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TestFile" ofType:@"plist"]];
    for (NSDictionary * dict in datas) {
        LXCollectionItemModel * cItem = [LXCollectionItemModel collectionItemModelWithDict:dict];
        [mArray addObject:cItem];
    }
    self.dataArray = mArray;
    [self.collectionView reloadData];
    
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseItem" forIndexPath:indexPath];
    
    LXCollectionViewCell * cell = [LXCollectionViewCell collectionViewCellWithCollectionView:collectionView indexPath:indexPath];
    cell.itemModel = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (self.view.frame.size.width - (Column + 1) * Margin) / Column;
    
    LXCollectionItemModel * itemModel = self.dataArray[indexPath.row];
    
    CGFloat height = width / itemModel.imageWidth * itemModel.imageHeight;
    
    return CGSizeMake(width, height);
    
}

@end
