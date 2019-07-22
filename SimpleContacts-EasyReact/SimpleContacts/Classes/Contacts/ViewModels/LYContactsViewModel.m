//   
//	LYContactsViewModel.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYContactsViewModel.h"
#import "LYContact.h"

@interface LYContactsViewModel ()

/// 注销按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *logoutCommand;


@end

@implementation LYContactsViewModel

- (void)initialize {
    [super initialize];
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x boolValue]) {
            self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:LYFilePath];
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD showErrorWithStatus:@"数据加载失败"];
        } 
        
        [self.refreshEndSubject sendNext:nil];
    }];
    
    [[[self.refreshDataCommand.executing skip:1] take:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqualToNumber:@(YES)]) {
            [SVProgressHUD showWithStatus:@"正在加载"];
        }
    }];
}

#pragma mark - Public
- (void)addContact:(id)contact {
    if ([contact isKindOfClass:LYContact.class]) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contacts];
        [tempArray addObject:contact];
        self.contacts = [tempArray copy];
    }
    // 归档
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:LYFilePath];
}

- (void)removeContactAtIndex:(NSUInteger)index {
    if (index < self.contacts.count) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contacts];
        [tempArray removeObjectAtIndex:index];
        self.contacts = [tempArray copy];
    }
    // 归档
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:LYFilePath];
}

- (void)updateContactAtIndex:(NSUInteger)index newContact:(id)contact {
    if (index < self.contacts.count) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.contacts];
        [tempArray replaceObjectAtIndex:index withObject:contact];
        self.contacts = [tempArray copy];
    }
    // 归档
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:LYFilePath];
}

#pragma mark - Getter
- (RACCommand *)logoutCommand {
    if (!_logoutCommand) {
        _logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _logoutCommand;
}

- (RACCommand *)refreshDataCommand {
    if (!_refreshDataCommand) {
//        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//            @strongify(self);
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                // 模拟网络请求
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
#define isSuccess 1
#ifdef isSuccess
                    [subscriber sendNext:@(1)];
                    [subscriber sendCompleted];
#else
                    [subscriber sendNext:@(0)];
                    [subscriber sendCompleted];
#endif
                });
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

- (RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

@end
