//   
//	LYEditContactViewModel.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/22
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewModel.h"

@class LYContact;

NS_ASSUME_NONNULL_BEGIN

@interface LYEditContactViewModel : LYViewModel

/// 姓名
@property (nonatomic, readwrite, copy) NSString *name;

/// 电话
@property (nonatomic, readwrite, copy) NSString *phone;

/// Model
@property (nonatomic, readwrite, strong) LYContact *contact;

/// 是否填充姓名和电话
@property (nonatomic, readonly, strong) RACSignal *nameFieldSignal;
@property (nonatomic, readonly, strong) RACSignal *phoneFieldSignal;

/// 按钮能否点击
@property (nonatomic, readonly, strong) RACSignal *validAddSignal;

/// 按钮是否隐藏
@property (nonatomic, readonly, strong) RACSignal *hiddenSaveSignal;

/// 按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *addCommand;

/// 按钮点击执行的命令
@property (nonatomic, readonly, strong) RACCommand *saveCommand;

@end

NS_ASSUME_NONNULL_END
