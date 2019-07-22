//   
//	LYAddContactsViewController.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYAddContactsViewController : LYViewController

/**代理信号*/
@property (nonatomic, strong) RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
