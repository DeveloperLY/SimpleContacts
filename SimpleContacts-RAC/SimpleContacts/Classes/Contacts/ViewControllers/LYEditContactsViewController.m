//   
//	LYEditContactsViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/22
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYEditContactsViewController.h"
#import "LYEditContactViewModel.h"

@interface LYEditContactsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

/** 视图模型 */
@property (nonatomic, strong) LYEditContactViewModel *viewModel;

@end

@implementation LYEditContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)bindViewModel {
    [super bindViewModel];
    
    self.viewModel.contact = self.contact;
    
    RAC(self.nameField, text) = self.viewModel.nameFieldSignal;
    RAC(self.phoneField, text) = self.viewModel.phoneFieldSignal;
    RAC(self.saveButton, enabled) = self.viewModel.validAddSignal;
    
    RAC(self.viewModel, name) = [RACSignal merge:@[RACObserve(self.nameField, text), self.nameField.rac_textSignal, self.nameField.rac_newTextChannel]];
    RAC(self.viewModel, phone) = [RACSignal merge:@[RACObserve(self.phoneField, text), self.phoneField.rac_textSignal, self.phoneField.rac_newTextChannel]];
    
    @weakify(self);
    // 登录按钮点击
    [[[self.saveButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"正在保存..."];
    }] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel.saveCommand execute:nil];
    }];
    
    [self.viewModel.saveCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [SVProgressHUD dismiss];
        
        if (self.delegateSignal) {
            [self.delegateSignal sendNext:x];
        }
        
        [self.navigationController popViewControllerAnimated:YES]; 
    }];
}

- (IBAction)edit:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        self.saveButton.hidden = NO;
        [self.phoneField becomeFirstResponder];
        sender.title = @"取消";
    } else {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        self.saveButton.hidden = YES;
        
        [self.view endEditing:YES];
        
        sender.title = @"编辑";
    }
}

#pragma mark - Getter
- (LYEditContactViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYEditContactViewModel alloc] init];
    }
    return _viewModel;
}

@end
