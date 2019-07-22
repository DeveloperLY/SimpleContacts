//   
//	LYViewModel.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYViewModel.h"

@implementation LYViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    LYViewModel *viewModel = [super allocWithZone:zone];
    if (viewModel) {
        [viewModel initialize];
    }
    return viewModel;
}

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        
    }
    return self;
}

/// sub class can override
- (void)initialize {}

@end
