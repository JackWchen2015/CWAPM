//
//  CWAppFluencyMonitor.h
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/9.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 监听UI线程卡顿
 */
@interface CWAppFluencyMonitor : NSObject
+ (instancetype)monitor;

- (void)startMonitoring;
- (void)stopMonitoring;
@end

NS_ASSUME_NONNULL_END
