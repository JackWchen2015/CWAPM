//
//  CWGlobalTimer.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWGlobalTimer.h"
#import "YYDispatchQueuePool+Block.h"
@implementation CWGlobalTimer

static NSUInteger cw_timer_time_interval = 2;
static dispatch_source_t cw_global_timer = NULL;
static CFMutableDictionaryRef cw_global_callbacks = NULL;


CF_INLINE void __CWInitGlobalCallbacks() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cw_global_callbacks = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    });
}

CF_INLINE void __CWSyncExecute(dispatch_block_t block) {
    CWDispatchQueueAsyncBlockInBackground(^{
        assert(block != nil);
        block();
    });
}

CF_INLINE void __CWResetTimer() {
    if (cw_global_timer != NULL) {
        dispatch_source_cancel(cw_global_timer);
    }
    cw_global_timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, CWDispatchQueueAsyncBlockInDefault(^{}));
    dispatch_source_set_timer(cw_global_timer, DISPATCH_TIME_NOW, cw_timer_time_interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(cw_global_timer, ^{
        NSUInteger count = CFDictionaryGetCount(cw_global_callbacks);
        void * callbacks[count];
        CFDictionaryGetKeysAndValues(cw_global_callbacks, NULL, (const void **)callbacks);
        for (uint idx = 0; idx < count; idx++) {
            dispatch_block_t callback = (__bridge dispatch_block_t)callbacks[idx];
            callback();
        }
    });
}


CF_INLINE void __CWAutoSwitchTimer() {
    if (CFDictionaryGetCount(cw_global_callbacks) > 0) {
        if (cw_global_timer == NULL) {
            __CWResetTimer();
            dispatch_resume(cw_global_timer);
        }
    } else {
        if (cw_global_timer != NULL) {
            dispatch_source_cancel(cw_global_timer);
            cw_global_timer = NULL;
        }
    }
}

/*!
 *  @brief  注册定时器回调处理，返回时间戳作为key
 */
+ (NSString *)registerTimerCallback: (dispatch_block_t)callback
{
    NSString * key = [NSString stringWithFormat: @"%.2f", [[NSDate date] timeIntervalSince1970]];
    [self registerTimerCallback: callback key: key];
    return key;
}

/*!
 *  @brief  注册定时器回调处理
 */
+ (void)registerTimerCallback: (dispatch_block_t)callback key: (NSString *)key
{
    if (!callback) { return; }
    __CWInitGlobalCallbacks();
    __CWSyncExecute(^{
        CFDictionarySetValue(cw_global_callbacks, (__bridge void *)key, (__bridge void *)[callback copy]);
        __CWAutoSwitchTimer();
    });
}

/*!
 *  @brief  取消定时器注册
 */
+ (void)resignTimerCallbackWithKey: (NSString *)key
{
    if (key == nil) { return; }
    __CWInitGlobalCallbacks();
    __CWSyncExecute(^{
        CFDictionaryRemoveValue(cw_global_callbacks, (__bridge void *)key);
        __CWAutoSwitchTimer();
    });
}

/*!
 *  @brief  设置定时器间隔，默认为2
 */
+ (void)setCallbackInterval: (NSUInteger)interval
{
    if (interval <= 0) { interval = 1; }
    cw_timer_time_interval = interval;
}
@end
