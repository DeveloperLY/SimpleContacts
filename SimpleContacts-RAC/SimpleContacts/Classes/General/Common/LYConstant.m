//   
//	LYConstant.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYConstant.h"

// 登录的账号
NSString * const LYLoginAccountKey = @"LYLoginAccountKey";
//// 登录的密码
NSString * const LYLoginPasswordKey = @"LYLoginPasswordKey";


/// 项目中关于一些简单的业务逻辑验证放在ViewModel的命令中统一处理 NSError
/// eg：假设输入的账号错误：
/// [RACSignal error:[NSError errorWithDomain:LYCommandErrorDomain code:LYCommandErrorCode userInfo:@{LYCommandErrorUserInfoKey:@"请输入正确的账号"}]];
NSString * const LYCommandErrorDomain = @"LYCommandErrorDomain";
NSString * const LYCommandErrorUserInfoKey = @"LYCommandErrorUserInfoKey";
CGFloat    const LYCommandErrorCode = 4004;


/// 传递导航栏title的key：例如 导航栏的title...
NSString * const LYViewModelTitleKey = @"LYViewModelTitleKey";
