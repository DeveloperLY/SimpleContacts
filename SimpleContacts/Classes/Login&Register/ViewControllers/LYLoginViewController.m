//   
//	LYLoginViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/18
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYLoginViewController.h"
#import "LYLoginAnimationView.h"
#import "LYLoginViewModel.h"

@interface LYLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet LYLoginAnimationView *animLoginView;

@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

/// 模型视图
@property (nonatomic, strong) LYLoginViewModel *viewModel;

@end

@implementation LYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view.
}


/// binding viewModel
- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.accountField, text) = self.viewModel.accountFieldSignal;
    RAC(self.passwordField, text) = self.viewModel.pwdFieldSignal;
    RAC(self.rmbPwdSwitch, on) = self.viewModel.rmbPwdSignal;
    RAC(self.autoLoginSwitch, on) = self.viewModel.autoLoginSignal;
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;
    
    RAC(self.viewModel, account) = [RACSignal merge:@[RACObserve(self.accountField, text), self.accountField.rac_textSignal, self.accountField.rac_newTextChannel]];
    RAC(self.viewModel, password) = [RACSignal merge:@[RACObserve(self.passwordField, text), self.passwordField.rac_textSignal, self.passwordField.rac_newTextChannel]];
    
    RAC(self.viewModel, isSavePassword) = [RACSignal merge:@[RACObserve(self.rmbPwdSwitch, isOn), self.rmbPwdSwitch.rac_newOnChannel]];
    RAC(self.viewModel, isAutoLogin) = [RACSignal merge:@[RACObserve(self.autoLoginSwitch, isOn), self.autoLoginSwitch.rac_newOnChannel]];
    
    
    @weakify(self);
    // 登录按钮点击
    [[[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Loading..."];
    }] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel.loginCommand execute:nil];
    }];
    
    // 登录成功
    [self.viewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [SVProgressHUD dismiss];
        // 跳转页面
        NSLog(@"跳转页面...");
        [self performSegueWithIdentifier:@"login2contacts" sender:self.viewModel.account];
    }];
    
    /// 错误信息
    [self.viewModel.loginCommand.errors subscribeNext:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"登录失败...");
        /// 处理验证错误的error
        if ([error.domain isEqualToString:LYCommandErrorDomain]) {
            [SVProgressHUD showErrorWithStatus:error.userInfo[LYCommandErrorUserInfoKey]];
            return ;
        }
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
    
    if (self.viewModel.isAutoLogin) {
        [self.viewModel.loginCommand execute:nil];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    vc.title = [NSString stringWithFormat:@"%@的联系人列表", sender];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 0: {
            [self.animLoginView startAnim:NO];
        }
        break;
        case 1: {
            [self.animLoginView startAnim:YES];
        }
        break;
    }
}

#pragma mark - Setter
- (LYLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYLoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
