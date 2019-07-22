//   
//	UtilsMacro.h
//  SimpleContacts
//   
//  Created by LiuY on 2019/7/18
//  Copyright © 2019 DeveloperLY. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

// 强弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type; // weak
#define StrongSelf(type)  __strong typeof(type) type = weak##type; // strong

#define LYFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"contacts.data"]

#endif /* UtilsMacro_h */
