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
#import "CWFPSDisplayView.h"
#import "CWWeakProxy.h"
#import "CWAppFluencyMonitor.h"
@interface CWPerformanceMonitorManager()
@property(nonatomic,strong)CWCPUDisplayView* cpuDisplayer;
@property(nonatomic,strong)CWMemoryDisplayView* memoryDisplayer;
@property (nonatomic, strong) CWFPSDisplayView * fpsdisplayer;

@property (nonatomic, strong) CADisplayLink * displayLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;
@end
@implementation CWPerformanceMonitorManager

static NSString * cw_resource_monitor_callback_key;

- (instancetype)init {
     if (self = [super init]) {
         [self loadSubView];
     }
    return self;
}

-(void)loadSubView
{
    self.cpuDisplayer = [[CWCPUDisplayView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2-20, 60,20)];
    self.memoryDisplayer = [[CWMemoryDisplayView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height/2+5, 60,20)];
    self.fpsdisplayer=[[CWFPSDisplayView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2+30, 60, 20)];
    [[CWTopWindow topWindow] addSubview: self.cpuDisplayer];
    [[CWTopWindow topWindow] addSubview:self.memoryDisplayer];
    [[CWTopWindow topWindow] addSubview:self.fpsdisplayer];
}
+(instancetype)sharedInstance
{
    static CWPerformanceMonitorManager* singleInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleInstance=[[CWPerformanceMonitorManager alloc] init];
    });
    return singleInstance;
}

- (void)startMonitoring
{
    if (cw_resource_monitor_callback_key != nil) { return; }
    cw_resource_monitor_callback_key = [[CWGlobalTimer registerTimerCallback: ^{
        [self.cpuDisplayer displayCPUUsage: [CWCPUMonitor appCpuUsage]];
        [self.memoryDisplayer displayUsage: [CWAppMemoryUsage currentUsage].usage];
    }] copy];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget: [CWWeakProxy proxyWithTarget: self] selector: @selector(monitor:)];
    [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
    self.lastTime = self.displayLink.timestamp;
    if ([self.displayLink respondsToSelector: @selector(setPreferredFramesPerSecond:)]) {
        self.displayLink.preferredFramesPerSecond = 60;
    } else {
        self.displayLink.frameInterval = 1;
    }
    
    
    [[CWAppFluencyMonitor monitor] startMonitoring];
}

- (void)stopMonitoring {
    if (cw_resource_monitor_callback_key == nil) { return; }
    [CWGlobalTimer resignTimerCallbackWithKey: cw_resource_monitor_callback_key];
    [self.cpuDisplayer removeFromSuperview];
    [self.memoryDisplayer removeFromSuperview];
    [[CWAppFluencyMonitor monitor] stopMonitoring];
    [self.fpsdisplayer removeFromSuperview];
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark - DisplayLink
- (void)monitor: (CADisplayLink *)link {
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) { return; }
    _lastTime = link.timestamp;
    
    double fps = _count / delta;
    _count = 0;
    [self.fpsdisplayer updateFPS: (int)round(fps)];
}
@end
