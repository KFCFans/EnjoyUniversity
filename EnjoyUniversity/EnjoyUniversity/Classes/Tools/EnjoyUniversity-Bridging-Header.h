//
//  EnjoyUniversity-Bridging-Header.h
//  EnjoyUniversity
//
//  Created by lip on 17/4/27.
//  Copyright © 2017年 lip. All rights reserved.
//

#ifdef EnjoyUniversity_Bridging_Header_h
#define EnjoyUniversity_Bridging_Header_h

// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>

#endif /* EnjoyUniversity_Bridging_Header_h */
