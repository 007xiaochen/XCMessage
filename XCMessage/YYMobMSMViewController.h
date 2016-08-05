//
//  YYMobMSMViewController.h
//  XCMessage
//
//  Created by 小陈 on 16/3/18.
//  Copyright © 2016年 小陈. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYMobMSMViewController : UIViewController
/// 获取验证码
- (void)obtainVerifyCodeAction:(NSString *)PhoneNumeberStr;
/// 提交验证码
- (void)commitVerifyCodeAction:(id) verify And:(NSString *)PhoneNumeberStr;
@end
