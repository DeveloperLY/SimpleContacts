//   
//	LYContactsViewModel.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYContactsViewModel.h"

@interface LYContactsViewModel ()

@end

@implementation LYContactsViewModel


#pragma mark - Getter
- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

@end
