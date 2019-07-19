//   
//	LYContact.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYContact : NSObject <NSCoding>

/** 姓名 */
@property (nonatomic, strong) NSString *name;
/** 电话 */
@property (nonatomic, strong) NSString *phone;

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END
