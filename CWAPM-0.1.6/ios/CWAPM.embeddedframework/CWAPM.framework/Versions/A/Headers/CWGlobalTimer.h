//
//  CWGlobalTimer.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 全局倒计时
 */
@interface CWGlobalTimer : NSObject
/*!
 *  @brief  注册定时器回调处理，返回时间戳作为key
 */
+ (NSString *)registerTimerCallback: (dispatch_block_t)callback;

/*!
 *  @brief  注册定时器回调处理
 */
+ (void)registerTimerCallback: (dispatch_block_t)callback key: (NSString *)key;

/*!
 *  @brief  取消定时器注册
 */
+ (void)resignTimerCallbackWithKey: (NSString *)key;

/*!
 *  @brief  设置定时器间隔，默认为2
 */
+ (void)setCallbackInterval: (NSUInteger)interval;
@end

NS_ASSUME_NONNULL_END
