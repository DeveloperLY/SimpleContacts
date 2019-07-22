//   
//	LYContact.m
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/19
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#import "LYContact.h"

#define LYNameKey @"name"
#define LYPhoneKey @"phone"


@implementation LYContact

+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone {
    LYContact *contact = [[self alloc] init];
    contact.name = name;
    contact.phone = phone;
    return contact;
}

#pragma mark 归档的时候调用
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:LYNameKey];
    [aCoder encodeObject:_phone forKey:LYPhoneKey];
}

#pragma mark 解档的时候调用
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:LYNameKey];
        _phone = [aDecoder decodeObjectForKey:LYPhoneKey];
    }
    return self;
}


@end
