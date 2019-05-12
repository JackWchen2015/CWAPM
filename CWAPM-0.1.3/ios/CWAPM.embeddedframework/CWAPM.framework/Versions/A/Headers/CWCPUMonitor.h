//
//  CWCPUMonitor.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/10/30.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface CWCPUMonitor : NSObject

/**
 任务（task）是一种容器（container）对象，虚拟内存空间和其他资源都是通过这个容器对象管理的，这些资源包括设备和其他句柄。严格地说，Mach 的任务并不是其他操作系统中所谓的进程，因为 Mach 作为一个微内核的操作系统，并没有提供“进程”的逻辑，而只是提供了最基本的实现。不过在 BSD 的模型中，这两个概念有1：1的简单映射，每一个 BSD 进程（也就是 OS X 进程）都在底层关联了一个 Mach 任务对象

 @return 
 */
+(CGFloat)appCpuUsage;
+ (NSUInteger)cpuNumber;

    
+(instancetype)shareInstance;
/**
 <#Description#>

 @return MHz
 */
//+(CGFloat)GetCPUFrequency;

@property(nonatomic,strong)NSString* cpuTypeString;
@property(nonatomic,strong)NSString* cpuSubtypeString;
@property(nonatomic,assign)NSInteger cpuType;
@property(nonatomic,assign)NSInteger cpuSubtype;
@end

NS_ASSUME_NONNULL_END
