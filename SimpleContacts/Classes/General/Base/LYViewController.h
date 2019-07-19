//   
//	LYViewController.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/18
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYViewModel.h" 

NS_ASSUME_NONNULL_BEGIN

@interface LYViewController : UIViewController

/// Initialization method. This is the preferred way to create a new view.
///
/// viewModel - corresponding view model
///
/// Returns a new view.
- (instancetype)initWithViewModel:(LYViewModel *)viewModel;

/// Binds the corresponding view model to the view.
- (void)bindViewModel;

@end

NS_ASSUME_NONNULL_END
