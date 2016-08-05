//
//  YYMobMSMViewController.m
//  XCMessage
//
//  Created by 小陈 on 16/3/18.
//  Copyright © 2016年 小陈. All rights reserved.
//

#import "YYMobMSMViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface YYMobMSMViewController ()


@property (nonatomic, strong) UITextField *text;
@end

@implementation YYMobMSMViewController

/**
 *   获取验证码
 *
 *  @param PhoneNumeberStr 电环号码
 */
- (void)obtainVerifyCodeAction:(NSString *)PhoneNumeberStr
{
#warning 更改输入电话号码
//    NSString * phoneNumeberStr = @"18826405234";
    // 检查是否填写正确的电话号码
    NSString *phoneNumber = PhoneNumeberStr;
    if ( ![self verifyPhoneNumber:phoneNumber]) {
        NSLog(@"请输入正确的电话号码");
    }
    

    // 申请短信验证码
    //注意区号和手机号码前面都不要加“＋”号，有的开发者喜欢这样写，@“＋86”，这种是错误的写法
    
    // 新版本的使用
    /**
     *  method 这个参数可以选择是通过发送验证码还是语言来获取验证码
     *  customIdentifier 可以自定义短信模板标识
     */
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumber zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (error) {
            NSLog(@"获取短信验证码失败: %@", error);
        } else {
            NSLog(@"获取短信验证码成功");
        }
    }];
}


/**
 *  提交验证码
 *
 *  @param verify          验证码
 *  @param PhoneNumeberStr 电话号码
 */
- (void)commitVerifyCodeAction:(id) verify And:(NSString *)PhoneNumeberStr{

    // 新版本
    [SMSSDK  commitVerificationCode:verify phoneNumber:PhoneNumeberStr zone:@"86" result:^(NSError *error) {
  
        if (error) {
            NSLog(@"%@",error);
            NSLog(@"验证失败");
            return ;
        }
        
        NSLog(@"验证成功");
    }];
}
// 手机号码验证
- (BOOL)verifyPhoneNumber:(NSString *)string
{
    NSString *pattern = @"^(0|86)?1([358][0-9]|7[678]|4[57])\\d{8}$";
    
    NSError *error = nil;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
    if (error) {
        NSLog(@"正则表达式创建失败");
        return nil;
    }
    
    NSTextCheckingResult *result = [regular firstMatchInString:string options:0 range:NSMakeRange(0, string.length)];
    if (result) {
        NSLog(@"匹配成功");
        return YES;
    } else {
        NSLog(@"匹配失败");
        return NO;
    }
}


@end
