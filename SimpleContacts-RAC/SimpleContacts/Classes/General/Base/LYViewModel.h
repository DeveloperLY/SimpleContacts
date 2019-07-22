//   
//	LYViewModel.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN 

@interface LYViewModel : NSObject

- (instancetype)initWithModel:(id)model;

/**
 *  初始化
 */
- (void)initialize;

@end

NS_ASSUME_NONNULL_END
