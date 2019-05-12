//
//  CWBacktraceLogger.h
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/9.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 获取线程堆栈
 */
@interface CWBacktraceLogger : NSObject
+ (NSString *)cw_backtraceOfAllThread;
+ (NSString *)cw_backtraceOfMainThread;
+ (NSString *)cw_backtraceOfCurrentThread;
+ (NSString *)cw_backtraceOfNSThread:(NSThread *)thread;

+ (void)cw_logMain;
+ (void)cw_logCurrent;
+ (void)cw_logAllThread;

+ (NSString *)backtraceLogFilePath;
+ (void)recordLoggerWithFileName: (NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
