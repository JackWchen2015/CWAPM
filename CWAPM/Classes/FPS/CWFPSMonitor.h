//
//  CWFPSMonitor.h
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/8.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWFPSMonitor : NSObject
+ (instancetype)sharedMonitor;

- (void)startMonitoring;
- (void)stopMonitoring;
-(void)testFunction;
@end

NS_ASSUME_NONNULL_END
