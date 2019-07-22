//   
//	LYEditContactsViewController.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/22
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewController.h"
@class LYContact;

NS_ASSUME_NONNULL_BEGIN

@interface LYEditContactsViewController : LYViewController

/**联系人*/
@property (nonatomic, strong) LYContact *contact;

/**代理信号*/
@property (nonatomic, strong) RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
