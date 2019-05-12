//
//  CWAppMemoryUsage.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct CWApplicationMemoryUsage
{
    double usage;   ///< 已用内存(MB)
    double total;   ///< 总内存(MB)
    double ratio;   ///< 占用比率
}CWApplicationMemoryUsage;

@interface CWAppMemoryUsage : NSObject
+(CWApplicationMemoryUsage)currentUsage;
@end

NS_ASSUME_NONNULL_END
