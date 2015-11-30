//
//  ZLockConst.h
//  ZLockDemo
//
//  Created by 张彦东 on 15/11/30.
//  Copyright © 2015年 yd. All rights reserved.
//

#ifndef ZLockConst_h
#define ZLockConst_h

/* Message */
#define kNormalMessageRegist @"输入新密码"
#define kNormalMessageModify @"输入原始密码"
#define kNormalMessageVerify @"输入验证密码"
#define kNormalMessageSecond @"再次绘制"

#define kSuccessMessageRegist @"手势密码创建成功"
#define kSuccessMessageModify @"手势密码修改成功"
#define kSuccessMessageVerify @"手势密码验证成功"

#define kWarningMessageLowNodes @"请连接至少四个节点"
#define kWarningMessageVerify @"手势密码验证错误"
#define kWarningMessageSecond @"两次密码不一致"


/* Attribute */
#define kPassCodeKey @"ZLockPassCode"
#define kControllerBackgroundColor [UIColor cyanColor]


/* ZLockView */
#define kViewNodeImageNameNormal @"node_normal"
#define kViewNodeImageNameSelected @"node_selected"
#define kViewLineColor [[UIColor yellowColor] colorWithAlphaComponent:0.75]  // 线段颜色

#define kViewNumberOfNodes 9  // 节点数
#define kViewRowNumber 3 // 行数
#define kViewMarginOfNodes 30  // 节点间距
#define kViewLineWidth 6  // 线段宽
#define kViewDefaultPoint CGPointMake(-1, -1)  // 默认位置


/* ZLockMessageView */
#define kViewTitleColor [UIColor whiteColor]
#define kViewTitleFont [UIFont boldSystemFontOfSize:24]
#define kViewMessageFont [UIFont systemFontOfSize:14]
#define kViewCloseButtonText @"关闭"
#define kViewCloseButtonColor [UIColor whiteColor]
#define kViewCloseButtonFont [UIFont systemFontOfSize:17]

#endif /* ZLockConst_h */
