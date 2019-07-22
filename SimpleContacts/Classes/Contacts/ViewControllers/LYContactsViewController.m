//   
//	LYContactsViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYContactsViewController.h"
#import "LYContactsViewModel.h"
#import "LYContact.h"
#import "LYAddContactsViewController.h"
#import "LYEditContactsViewController.h"

@interface LYContactsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 模型视图
@property (nonatomic, strong) LYContactsViewModel *viewModel;

@end

@implementation LYContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)bindViewModel {
    @weakify(self);
    [self.viewModel.logoutCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要注销？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        // 添加按钮
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertController addAction:sure];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        // 在当前控制器上面弹出另一个控制器：alertController
        [self presentViewController:alertController animated:YES completion:nil];
    }];
    
    [self.viewModel.refreshDataCommand execute:nil];
    
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        [self.tableView reloadData];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[LYAddContactsViewController class]]) {
        LYAddContactsViewController *addVC = segue.destinationViewController;
        addVC.delegateSignal = [RACSubject subject];
        @weakify(self);
        [addVC.delegateSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            LYContact *contact = x;
            // 添加数据
            [self.viewModel addContact:contact];
            // 刷新表格
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.viewModel.contacts.count - 1 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }];
    } else {
        NSUInteger index = [self.tableView indexPathForSelectedRow].row;
        LYEditContactsViewController *editVC = segue.destinationViewController;
        editVC.contact = self.viewModel.contacts[index];
        editVC.delegateSignal = [RACSubject subject];
        @weakify(self);
        [editVC.delegateSignal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            
            LYContact *contact = x;
            // 添加数据
            [self.viewModel updateContactAtIndex:index newContact:contact];
            // 刷新表格
            [self.tableView reloadRowsAtIndexPaths:@[[self.tableView indexPathForSelectedRow]] withRowAnimation:UITableViewRowAnimationRight];
        }];
    }
}

- (IBAction)logout:(id)sender {
    [self.viewModel.logoutCommand execute:nil];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contact_cell"];
    
    LYContact *contact = self.viewModel.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel removeContactAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    }
}

- (LYContactsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LYContactsViewModel alloc] init];
    }
    return _viewModel;
}

@end
