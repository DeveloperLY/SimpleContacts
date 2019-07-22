//   
//	LYViewController.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/18
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewController.h"

@interface LYViewController ()

@end

@implementation LYViewController

// when `BaseViewController ` created and call `viewDidLoad` method , execute `bindViewModel` method
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LYViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
         @strongify(viewController)
         [viewController bindViewModel];
     }];
    return viewController;
}


- (instancetype)initWithViewModel:(LYViewModel *)viewModel {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

#ifdef __IPHONE_11_0
    /// ignore adjust scroll 64
    self.automaticallyAdjustsScrollViewInsets = YES;
#else
    /// ignore adjust scroll 64
    self.automaticallyAdjustsScrollViewInsets = NO;
#endif
}



// bind the viewModel
- (void)bindViewModel {}

@end
