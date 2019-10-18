//
//  CWCPUMonitorManager.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWPerformanceMonitorManager : NSObject
+(instancetype)sharedInstance;
- (void)startMonitoring;
- (void)stopMonitoring;
@end

NS_ASSUME_NONNULL_END
