//
//  LXOtherViewController.m
//  iOSstation
//
//  Created by 张彦东 on 15/11/23.
//  Copyright © 2015年 lx. All rights reserved.
//

#import "LXOtherViewController.h"
#import "LXLoginViewController.h"
#import "ZLockController.h"

@interface LXOtherViewController () <LXLoginViewControllerDelegate>

@property (nonatomic, assign, getter=isLogin) BOOL login;

@property (weak, nonatomic) IBOutlet UILabel *loginTextLabel;

@property (nonatomic, copy) NSString * pwd;


@end

@implementation LXOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"UserLogin"]) {
        
        LXLoginViewController * desCtr = segue.destinationViewController;
        
        desCtr.login = self.login;
        desCtr.delegate = self;
    }
}

- (void)loginViewControllerLoginButtonDidClick:(LXLoginViewController *)viewController isLogin:(BOOL)isLogin {
    
    if (isLogin != self.isLogin) {
        
        self.login = isLogin;
        self.loginTextLabel.text = self.isLogin ? @"登陆" : @"未登录";
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    


    return cell;
}
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.1;
    }
    
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section != 3) return;
        
        switch (indexPath.row) {
            case 0:
                if ([ZLockController hasLocalPassCode]) {
                    [self showAlertViewWithTitle:@"已经设置过密码，可以修改或者重置密码"];
                } else {
                    [ZLockController showRegistLockVCInVC:self completeBlock:nil];
                }
                break;
            case 1:
                if ([ZLockController hasLocalPassCode]) {
                    [ZLockController showModifyLockVCInVC:self completeBlock:nil];
                } else {
                    [self showAlertViewWithTitle:@"还没有创建密码"];
                }
                break;
            case 2:
                if ([ZLockController hasLocalPassCode]) {
                    [ZLockController showVerifyLockVCInVC:self completeBlock:nil];
                } else {
                    [self showAlertViewWithTitle:@"请先设置密码"];
                }
                break;
            default:
                break;
        }
}

- (void)showAlertViewWithTitle:(NSString *)title {
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
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
