//
//  CWCPUDisplayView.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWCPUDisplayView : UIView
- (void)displayCPUUsage: (double)fusage;
@end

NS_ASSUME_NONNULL_END
