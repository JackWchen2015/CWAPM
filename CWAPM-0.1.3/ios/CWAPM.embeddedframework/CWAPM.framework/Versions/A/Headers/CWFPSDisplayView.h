//
//  CWFPSDisplay.h
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/8.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CWFPSDisplayView : UIView
- (void)updateFPS: (int)fps;
@end

NS_ASSUME_NONNULL_END
