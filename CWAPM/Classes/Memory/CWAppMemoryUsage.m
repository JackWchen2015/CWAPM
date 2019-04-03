//
//  CWAppMemoryUsage.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWAppMemoryUsage.h"
#import <mach/mach.h>
#import <mach/task_info.h>


#ifndef NBYTE_PER_MB
#define NBYTE_PER_MB (1024 * 1024)
#endif
@implementation CWAppMemoryUsage

+(CWApplicationMemoryUsage)currentUsage {
    
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t result = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (result == KERN_SUCCESS)
    {
        return (CWApplicationMemoryUsage){
            .usage = vmInfo.phys_footprint / NBYTE_PER_MB,
            .total = [NSProcessInfo processInfo].physicalMemory / NBYTE_PER_MB,
            .ratio = vmInfo.virtual_size / [NSProcessInfo processInfo].physicalMemory,
        };
    }
    else
    {
        return (CWApplicationMemoryUsage){ 0 };
    }
}

@end
