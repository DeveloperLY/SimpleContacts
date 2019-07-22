//   
//	LYConstant.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 登录的账号
FOUNDATION_EXTERN NSString * const LYLoginAccountKey;
//// 登录的密码
FOUNDATION_EXTERN NSString * const LYLoginPasswordKey;

/// 项目中关于一些简单的业务逻辑验证放在ViewModel的命令中统一处理 NSError
/// eg：假设输入的账号错误：
/// [RACSignal error:[NSError errorWithDomain:LYCommandErrorDomain code:LYCommandErrorCode userInfo:@{LYCommandErrorUserInfoKey:@"请输入正确的账号"}]];
FOUNDATION_EXTERN NSString * const LYCommandErrorDomain;
FOUNDATION_EXTERN NSString * const LYCommandErrorUserInfoKey;
FOUNDATION_EXTERN CGFloat    const LYCommandErrorCode;

FOUNDATION_EXTERN NSString * const LYViewModelTitleKey;
