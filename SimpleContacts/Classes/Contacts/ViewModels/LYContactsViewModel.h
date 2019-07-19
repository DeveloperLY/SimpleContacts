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

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end

NS_ASSUME_NONNULL_END
