//
//  LXHotViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/25.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXHotViewController.h"
#import "LXBannerView.h"
#import "LXHotViewCell.h"
#import "LXHotCellModel.h"
#import "MJRefresh.h"


@interface LXHotViewController ()

@property (nonatomic, strong) NSArray * dataArray;

@end

@implementation LXHotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array = @[@"http://img15.3lian.com/2015/f2/147/d/36.jpg",
                        @"http://a.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=cb9f41bdfe039245a1e0e909b7a488fa/e61190ef76c6a7efc64a1f56fffaaf51f3de6655.jpg",
                        @"http://img6.faloo.com/Picture/0x0/0/747/747488.jpg",
                        @"http://hiphotos.baidu.com/%95%D7%D4%AA%B5%C0/pic/item/432e6436d9cd9b4deac4af86.jpg"];
    
    
    LXBannerView * bannerView = [[LXBannerView alloc] init];
    self.tableView.tableHeaderView = bannerView;
    bannerView.imageUrls = array;
    
    
    NSArray * dicts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"HotFile" ofType:@"plist"]];
    NSMutableArray * dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary * dict in dicts) {
        LXHotCellModel * model = [LXHotCellModel hotCellModelWithDict:dict];
        [dataArray addObject:model];
    }
    self.dataArray = dataArray;
    
    [self.tableView reloadData];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData {
    
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:self.dataArray];
    for (int i = 3; i > 0; i--) {
        NSDictionary * dict = @{@"imageUrlStr" : @"http://img4q.duitang.com/uploads/item/201504/17/20150417H1719_VzWQv.jpeg",
                                @"title" : [NSString stringWithFormat:@"刷新的新数据%d", i]};
        LXHotCellModel * model = [LXHotCellModel hotCellModelWithDict:dict];
        [mArray insertObject:model atIndex:0];
    }
    self.dataArray = [mArray copy];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    
    NSMutableArray * mArray = [NSMutableArray arrayWithArray:self.dataArray];
    for (int i = 0; i < 3; i++) {
        NSDictionary * dict = @{@"imageUrlStr" : @"http://img4q.duitang.com/uploads/item/201504/17/20150417H1719_VzWQv.jpeg",
                                @"title" : [NSString stringWithFormat:@"加载的新数据%d", i]};
        LXHotCellModel * model = [LXHotCellModel hotCellModelWithDict:dict];
        [mArray addObject:model];
    }
    self.dataArray = [mArray copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        if (self.dataArray.count > 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (LXHotViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXHotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotCell" forIndexPath:indexPath];
    
    cell.cellModel = self.dataArray[indexPath.row];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
