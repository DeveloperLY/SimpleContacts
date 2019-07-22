//   
//	LYLoginViewModel.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYLoginViewModel.h"

#define LYAccountKey @"account"
#define LYPwdKey @"password"
#define LYRmbPwdKey @"rmb_pwd"
#define LYAutoLoginKey @"aoto_login"

@interface LYLoginViewModel ()

/// 账号是否填充
@property (nonatomic, readwrite, strong) EZRMutableNode *accountFieldNode;

/// 密码是否填充
@property (nonatomic, readwrite, strong) EZRMutableNode *pwdFieldNode;

/// 保存密码是否打开
@property (nonatomic, readwrite, strong) EZRMutableNode *rmbPwdNode;

/// 自动登录是否打开
@property (nonatomic, readwrite, strong) EZRMutableNode *autoLoginNode;

/// 按钮能否点击
@property (nonatomic, readwrite, strong) EZRMutableNode *validLoginNode;

/// 账号是否填充
@property (nonatomic, readwrite, strong) RACSignal *accountFieldSignal;

/// 密码是否填充
@property (nonatomic, readwrite, strong) RACSignal *pwdFieldSignal;

/// 保存密码是否打开
@property (nonatomic, readwrite, strong) RACSignal *rmbPwdSignal;

/// 自动登录是否打开
@property (nonatomic, readwrite, strong) RACSignal *autoLoginSignal;

/// 按钮能否点击
@property (nonatomic, readwrite, strong) RACSignal *validLoginSignal;

/// 登录按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *loginCommand;

@end

@implementation LYLoginViewModel

- (void)initialize {
    [super initialize];
    @ezr_weakify(self);
    
    // 读取数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.account = [defaults objectForKey:LYAccountKey];
    self.password = [defaults objectForKey:LYPwdKey];
    self.isSavePassword = [defaults boolForKey:LYRmbPwdKey];
    self.isAutoLogin = [defaults boolForKey:LYAutoLoginKey];
    
    self.accountFieldNode = [EZRCombine(EZR_PATH(self, account)) mapEach:^id _Nonnull(NSString * _Nonnull account) {
        @ezr_strongify(self);
        if (self.isSavePassword) {
            return account;
        } else {
            return @"";
        }
    }].mutablify;
    
    self.pwdFieldSignal = [[RACSignal combineLatest:@[RACObserve(self, password)] reduce:^(NSString *password) {
        @strongify(self);
        if (self.isSavePassword) {
            return password;
        } else {
            return @"";
        }
    }] distinctUntilChanged];
    
    /// 按钮是否打开
    self.rmbPwdSignal = [[RACSignal combineLatest:@[RACObserve(self, isSavePassword)] reduce:^(NSNumber *rmbPad) {
        @strongify(self);
        if (![rmbPad boolValue]) {
            self.isAutoLogin = NO;
        }
        return rmbPad;
    }] distinctUntilChanged];
    
    self.autoLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, isAutoLogin)] reduce:^(NSNumber *autoLogin) {
        @strongify(self);
        if ([autoLogin boolValue]) {
            self.isSavePassword = YES;
        }
        return autoLogin;
    }] distinctUntilChanged];
    
    /// 按钮有效性
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, password)] reduce:^(NSString *account, NSString *password) {
        return @(account.length > 0 && password.length > 0);
    }] distinctUntilChanged];
    
    /// 登录命令
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        // TODO 这里可以校验一下输入的账号密码格式
        
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            // 这里模拟一下网络请求
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                @strongify(self);
                
                if ([self.account isEqualToString:@"ly"] && [self.password isEqualToString:@"1122"]) {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    if (self.isSavePassword) {
                        // 保存数据
                        [defaults setObject:self.account forKey:LYAccountKey];
                        [defaults setObject:self.password forKey:LYPwdKey];
                        [defaults setBool:self.isSavePassword forKey:LYRmbPwdKey];
                        [defaults setBool:self.isAutoLogin forKey:LYAutoLoginKey];
                    } else {
                        [defaults setObject:nil forKey:LYAccountKey];
                        [defaults setObject:nil forKey:LYPwdKey];
                        [defaults setBool:self.isSavePassword forKey:LYRmbPwdKey];
                        [defaults setBool:self.isAutoLogin forKey:LYAutoLoginKey];
                    }
                    // 同步
                    [defaults synchronize];
                    
                    [subscriber sendNext:nil];
                    /// 必须sendCompleted 否则command.executing一直为1 导致HUD 一直 loading
                    [subscriber sendCompleted];
                } else {
                    /// 失败的回调 暂时这样处理一下，实际开发根据需求处理
                    [subscriber sendError:[NSError errorWithDomain:LYCommandErrorDomain code:LYCommandErrorCode userInfo:@{LYCommandErrorUserInfoKey:@"输入的账号或者密码错误"}]];
                }
            }); 
            return nil;
        }];
    }];
}

@end
