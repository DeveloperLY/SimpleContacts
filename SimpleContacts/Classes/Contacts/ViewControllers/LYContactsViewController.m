//   
//	LYContactsViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYContactsViewController.h"
#import "LYContactsViewModel.h"

@interface LYContactsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// 模型视图
@property (nonatomic, strong) LYContactsViewModel *viewModel;

@end

@implementation LYContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)bindViewModel {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}




@end
