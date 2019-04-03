//
//  YYDispatchQueuePool+Block.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "YYDispatchQueuePool+Block.h"

@implementation YYDispatchQueuePool (Block)

dispatch_queue_t CWDispatchQueueAsyncBlockInQOS(NSQualityOfService qos, dispatch_block_t block)
{
    if (block == nil) { return NULL; }
    dispatch_queue_t queue = YYDispatchQueueGetForQOS(qos);
    dispatch_async(queue, block);
    return queue;
}

dispatch_queue_t CWDispatchQueueAsyncBlockInUserInteractive(dispatch_block_t block)
{
    return CWDispatchQueueAsyncBlockInQOS(NSQualityOfServiceUserInteractive,block);
}
dispatch_queue_t CWDispatchQueueAsyncBlockInUserInitiated(dispatch_block_t block)
{
   return CWDispatchQueueAsyncBlockInQOS(NSQualityOfServiceUserInitiated,block);
}
dispatch_queue_t CWDispatchQueueAsyncBlockInBackground(dispatch_block_t block)
{
   return CWDispatchQueueAsyncBlockInQOS(NSQualityOfServiceBackground,block);
}
dispatch_queue_t CWDispatchQueueAsyncBlockInDefault(dispatch_block_t block)
{
   return CWDispatchQueueAsyncBlockInQOS(NSQualityOfServiceDefault,block);
}
dispatch_queue_t CWDispatchQueueAsyncBlockInUtility(dispatch_block_t block)
{
   return CWDispatchQueueAsyncBlockInQOS(NSQualityOfServiceUtility,block);
}
@end
