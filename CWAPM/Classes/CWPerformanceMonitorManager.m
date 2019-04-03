//
//  CWCPUMonitorManager.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWPerformanceMonitorManager.h"
#import "CWGlobalTimer.h"
#import "CWCPUDisplayView.h"
#import "CWCPUMonitor.h"
#import "CWCPUDisplayView.h"
#import "CWTopWindow.h"
#import "CWMemoryDisplayView.h"
#import "CWAppMemoryUsage.h"
@interface CWPerformanceMonitorManager()

@property(nonatomic,strong)CWCPUDisplayView* cpuDisplayer;
@property(nonatomic,strong)CWMemoryDisplayView* memoryDisplayer;
@end
@implementation CWPerformanceMonitorManager

static NSString * cw_resource_monitor_callback_key;

- (instancetype)init {
     if (self = [super init]) {
         self.cpuDisplayer = [[CWCPUDisplayView alloc] initWithFrame: CGRectMake(0, 30, 60, 20)];
         CGFloat centerX = round(CGRectGetWidth([UIScreen mainScreen].bounds) / 4);
         self.cpuDisplayer.center = CGPointMake(centerX, self.cpuDisplayer.center.y);
         
         self.memoryDisplayer = [[CWMemoryDisplayView alloc] initWithFrame: CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 140, 30, 60, 20)];
         CGFloat centerXMem = round(CGRectGetWidth([UIScreen mainScreen].bounds) / 4 * 3);
         self.memoryDisplayer.center = CGPointMake(centerXMem, self.memoryDisplayer.center.y);
     }
    return self;
}

- (void)startMonitoring
{
    if (cw_resource_monitor_callback_key != nil) { return; }
    cw_resource_monitor_callback_key = [[CWGlobalTimer registerTimerCallback: ^{
        [self.cpuDisplayer displayCPUUsage: [CWCPUMonitor appCpuUsage]];
        [self.memoryDisplayer displayUsage: [CWAppMemoryUsage currentUsage].usage];
    }] copy];
    
    [[CWTopWindow topWindow] addSubview: self.cpuDisplayer];
    [[CWTopWindow topWindow]addSubview:self.memoryDisplayer];
}

- (void)stopMonitoring {
    if (cw_resource_monitor_callback_key == nil) { return; }
    [CWGlobalTimer resignTimerCallbackWithKey: cw_resource_monitor_callback_key];
    [self.cpuDisplayer removeFromSuperview];
    [self.memoryDisplayer removeFromSuperview];
}

@end
