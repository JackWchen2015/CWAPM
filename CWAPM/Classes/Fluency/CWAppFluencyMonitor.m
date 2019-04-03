//
//  CWAppFluencyMonitor.m
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/9.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWAppFluencyMonitor.h"
#import "CWBacktraceLogger.h"

#define CW_SEMAPHORE_SUCCESS 0
static BOOL cw_is_monitoring = NO;
static dispatch_semaphore_t cw_semaphore;
static NSTimeInterval cw_time_out_interval = 0.5;

@implementation CWAppFluencyMonitor

static inline dispatch_queue_t __cw_fluecy_monitor_queue() {
    static dispatch_queue_t cw_fluecy_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        cw_fluecy_monitor_queue = dispatch_queue_create("com.sindrilin.cw_monitor_queue", NULL);
    });
    return cw_fluecy_monitor_queue;
}

static inline void __cw_monitor_init() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cw_semaphore = dispatch_semaphore_create(0);
    });
}

#pragma mark - Public
+ (instancetype)monitor {
    return [CWAppFluencyMonitor new];
}

- (void)startMonitoring {
    if (cw_is_monitoring) { return; }
    cw_is_monitoring = YES;
    __cw_monitor_init();
    dispatch_async(__cw_fluecy_monitor_queue(), ^{
        while (cw_is_monitoring) {
            __block BOOL timeOut = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                timeOut = NO;
                dispatch_semaphore_signal(cw_semaphore);
            });
            [NSThread sleepForTimeInterval: cw_time_out_interval];
            if (timeOut) {
                [CWBacktraceLogger cw_logMain];
            }
            dispatch_wait(cw_semaphore, DISPATCH_TIME_FOREVER);
        }
    });
}

- (void)stopMonitoring {
    if (!cw_is_monitoring) { return; }
    cw_is_monitoring = NO;
}
@end
