//   
//	LYAddContactsViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYAddContactsViewController.h"
#import "LYEditContactViewModel.h"

@interface LYAddContactsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

/** 视图模型 */
@property (nonatomic, strong) LYEditContactViewModel *viewModel;

@end

@implementation LYAddContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
}

- (void)bindViewModel {
    [super bindViewModel];
    
    RAC(self.addButton, enabled) = self.viewModel.validAddSignal;
    
    RAC(self.viewModel, name) = [RACSignal merge:@[RACObserve(self.nameTextField, text), self.nameTextField.rac_textSignal, self.nameTextField.rac_newTextChannel]];
    RAC(self.viewModel, phone) = [RACSignal merge:@[RACObserve(self.phoneTextField, text), self.phoneTextField.rac_textSignal, self.phoneTextField.rac_newTextChannel]];
    
    @weakify(self);
    // 登录按钮点击
    [[[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"正在保存..."];
    }] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel.addCommand execute:nil];
    }];
    
    [self.viewModel.addCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [SVProgressHUD dismiss];
        
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:x];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Getter
- (LYEditContactViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYEditContactViewModel alloc] init];
    }
    return _viewModel;
}

@end
