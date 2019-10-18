//
//  YYDispatchQueuePool+Block.h
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import <YYDispatchQueuePool/YYDispatchQueuePool.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYDispatchQueuePool (Block)
dispatch_queue_t CWDispatchQueueAsyncBlockInQOS(NSQualityOfService qos, dispatch_block_t block);
dispatch_queue_t CWDispatchQueueAsyncBlockInUserInteractive(dispatch_block_t block);
dispatch_queue_t CWDispatchQueueAsyncBlockInUserInitiated(dispatch_block_t block);
dispatch_queue_t CWDispatchQueueAsyncBlockInBackground(dispatch_block_t block);
dispatch_queue_t CWDispatchQueueAsyncBlockInDefault(dispatch_block_t block);
dispatch_queue_t CWDispatchQueueAsyncBlockInUtility(dispatch_block_t block);
@end

NS_ASSUME_NONNULL_END
