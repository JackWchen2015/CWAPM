//
//  CWFPSMonitor.m
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/8.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWFPSMonitor.h"
#import "CWWeakProxy.h"
#import "CWFPSDisplayView.h"
#import "CWTopWindow.h"
@interface CWFPSMonitor()
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) BOOL isMonitoring;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, strong) CWFPSDisplayView * displayer;
@property (nonatomic, strong) CADisplayLink * displayLink;
@end

@implementation CWFPSMonitor
#pragma mark - Singleton override
+ (instancetype)sharedMonitor {
    static CWFPSMonitor * sharedMonitor;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedMonitor = [[CWFPSMonitor alloc] init];
    });
    return sharedMonitor;
}



- (void)dealloc {
    [self stopMonitoring];
}


#pragma mark - Public
- (void)startMonitoring {
    if (_isMonitoring) { return; }
    _isMonitoring = YES;
    [self.displayer removeFromSuperview];
    CWFPSDisplayView * displayer = [[CWFPSDisplayView alloc] init];
    self.displayer = displayer;
    [[CWTopWindow topWindow] addSubview: self.displayer];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget: [CWWeakProxy proxyWithTarget: self] selector: @selector(monitor:)];
    [self.displayLink addToRunLoop: [NSRunLoop mainRunLoop] forMode: NSRunLoopCommonModes];
    self.lastTime = self.displayLink.timestamp;
    if ([self.displayLink respondsToSelector: @selector(setPreferredFramesPerSecond:)]) {
        self.displayLink.preferredFramesPerSecond = 60;
    } else {
        self.displayLink.frameInterval = 1;
    }
}

- (void)stopMonitoring {
    if (!_isMonitoring) { return; }
    _isMonitoring = NO;
    [self.displayer removeFromSuperview];
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.displayer = nil;
}


#pragma mark - DisplayLink
- (void)monitor: (CADisplayLink *)link {
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) { return; }
    _lastTime = link.timestamp;
    
    double fps = _count / delta;
    _count = 0;
    [self.displayer updateFPS: (int)round(fps)];
}
@end
