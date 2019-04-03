//
//  CWCPUMonitor.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/10/30.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//
#import <mach/mach.h>
#import <assert.h>
#import "CWCPUMonitor.h"
#import <mach/machine.h>
#import <mach-o/arch.h>

@implementation CWCPUMonitor
    
+(instancetype)shareInstance
{
    static CWCPUMonitor*   cwCPUSingle=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cwCPUSingle=[CWCPUMonitor new];
    });
    return cwCPUSingle;
}
static NSUInteger const kMaxPercent = 100;

+(CGFloat)appCpuUsage {
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    long total_time     = 0;
    long total_userTime = 0;
    CGFloat total_cpu   = 0;
    int j;
    
    // for each thread
    for (j = 0; j < (int)thread_count; j++) {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            total_time     = total_time + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            total_userTime = total_userTime + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            total_cpu      = total_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * kMaxPercent;
        }
    }
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return total_cpu;
}

extern int freqTest(int cycles);

static double GetCPUFrequency(void)
{
    volatile NSTimeInterval times[500];
    
    int sum = 0;
    
    for(int i = 0; i < 500; i++)
    {
        times[i] = [[NSProcessInfo processInfo] systemUptime];
        sum += freqTest(10000);
        times[i] = [[NSProcessInfo processInfo] systemUptime] - times[i];
    }
    
    NSTimeInterval time = times[0];
    for(int i = 1; i < 500; i++)
    {
        if(time > times[i])
            time = times[i];
    }
    
    double freq = 1300000.0 / time;
    return freq;
}
+(CGFloat)GetCPUFrequency
{
    return  GetCPUFrequency()/1e6;
}
+ (NSUInteger)cpuNumber {
    return [NSProcessInfo processInfo].activeProcessorCount;
}
+ (NSInteger)cpuType {
    return (NSInteger)NXGetLocalArchInfo()->cputype;
}

+ (NSInteger)cpuSubtype {
    return (NSInteger)NXGetLocalArchInfo()->cpusubtype;
}
- (NSString *)p_stringFromCpuType:(NSInteger)cpuType {
    switch (cpuType) {
        case CPU_TYPE_VAX:          return @"VAX";
        case CPU_TYPE_MC680x0:      return @"MC680x0";
        case CPU_TYPE_X86:          return @"X86";
        case CPU_TYPE_X86_64:       return @"X86_64";
        case CPU_TYPE_MC98000:      return @"MC98000";
        case CPU_TYPE_HPPA:         return @"HPPA";
        case CPU_TYPE_ARM:          return @"ARM";
        case CPU_TYPE_ARM64:        return @"ARM64";
        case CPU_TYPE_MC88000:      return @"MC88000";
        case CPU_TYPE_SPARC:        return @"SPARC";
        case CPU_TYPE_I860:         return @"I860";
        case CPU_TYPE_POWERPC:      return @"POWERPC";
        case CPU_TYPE_POWERPC64:    return @"POWERPC64";
        default:                    return @"Unknown";
    }
}
- (NSString *)cpuTypeString {
    if (!_cpuTypeString) {
        _cpuTypeString = [self p_stringFromCpuType:[[self class] cpuType]];
    }
    
    return _cpuTypeString;
}

- (NSString *)cpuSubtypeString {
    if (!_cpuSubtypeString) {
        _cpuSubtypeString = [NSString stringWithUTF8String:NXGetLocalArchInfo()->description];
    }
    
    return _cpuSubtypeString;
}
@end
