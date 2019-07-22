//   
//	LYLoginViewModel.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYLoginViewModel : LYViewModel

/// 账号
@property (nonatomic, readwrite, copy) NSString *account;

/// 密码
@property (nonatomic, readwrite, copy) NSString *password;

/// 是否保存密码
@property (nonatomic, readwrite, assign) BOOL isSavePassword;

/// 是否自动登录
@property (nonatomic, readwrite, assign) BOOL isAutoLogin;

/// 账号是否填充
@property (nonatomic, readonly, strong) RACSignal *accountFieldSignal;

/// 密码是否填充
@property (nonatomic, readonly, strong) RACSignal *pwdFieldSignal;

/// 保存密码是否打开
@property (nonatomic, readonly, strong) RACSignal *rmbPwdSignal;

/// 自动登录是否打开
@property (nonatomic, readonly, strong) RACSignal *autoLoginSignal;

/// 按钮能否点击
@property (nonatomic, readonly, strong) RACSignal *validLoginSignal;

/// 登录按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
