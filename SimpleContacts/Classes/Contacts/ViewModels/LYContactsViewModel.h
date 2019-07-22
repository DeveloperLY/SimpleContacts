//   
//	LYContactsViewModel.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYContactsViewModel : LYViewModel

/// 注销按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *logoutCommand;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) NSArray *contacts;

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACSubject *cellClickSubject;

- (void)addContact:(id)contact;

- (void)removeContactAtIndex:(NSUInteger)index;

- (void)updateContactAtIndex:(NSUInteger)index newContact:(id)contact;

@end

NS_ASSUME_NONNULL_END
