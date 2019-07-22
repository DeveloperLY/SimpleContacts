//   
//	LYEditContactViewModel.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/22
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYEditContactViewModel.h"
#import "LYContact.h"

@interface LYEditContactViewModel ()

/// 是否填充姓名和电话
@property (nonatomic, readwrite, strong) RACSignal *nameFieldSignal;
@property (nonatomic, readwrite, strong) RACSignal *phoneFieldSignal;

/// 按钮能否点击
@property (nonatomic, readwrite, strong) RACSignal *validAddSignal;

/// 按钮是否隐藏
@property (nonatomic, readwrite, strong) RACSignal *hiddenSaveSignal;

/// 按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *saveCommand;


/// 按钮点击执行的命令
@property (nonatomic, readwrite, strong) RACCommand *addCommand;

@end

@implementation LYEditContactViewModel

- (void)initialize {
    [super initialize];
    @weakify(self);
    
    if (self.contact) {
        self.name = self.contact.name;
        self.phone = self.contact.phone;
    }
    
    self.nameFieldSignal = [[RACSignal combineLatest:@[RACObserve(self, contact)] reduce:^(LYContact *contact) {
        return contact.name;
    }] distinctUntilChanged];
    
    self.phoneFieldSignal = [[RACSignal combineLatest:@[RACObserve(self, contact)] reduce:^(LYContact *contact) {
        return contact.phone;
    }] distinctUntilChanged];
    
    self.validAddSignal = [[RACSignal combineLatest:@[RACObserve(self, name), RACObserve(self, phone)] reduce:^(NSString *name, NSString *phone) {
        return @(name.length > 0 && phone.length > 0);
    }] distinctUntilChanged];
    
    self.addCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            LYContact *contact = [LYContact contactWithName:self.name phone:self.phone];
            [subscriber sendNext:contact];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    self.saveCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        @weakify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            LYContact *contact = [LYContact contactWithName:self.name phone:self.phone];
            self.contact = contact;
            [subscriber sendNext:contact];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

@end
