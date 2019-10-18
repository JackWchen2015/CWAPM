//
//  CWTopWindow.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWTopWindow.h"


@implementation CWTopWindow

static CWTopWindow * cw_top_window;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (instancetype)topWindow {
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cw_top_window = [[super allocWithZone: NSDefaultMallocZone()] initWithFrame: [UIScreen mainScreen].bounds];
    });
#endif
    return cw_top_window;
}

+ (instancetype)allocWithZone: (struct _NSZone *)zone {
    return [self topWindow];
}

- (instancetype)copy {
    return [[self class] topWindow];
}

- (instancetype)initWithFrame: (CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [super setUserInteractionEnabled: NO];
        [super setWindowLevel: CGFLOAT_MAX];
        self.rootViewController = [UIViewController new];
        [self makeKeyAndVisible];
    }
    return self;
}

- (void)setWindowLevel: (UIWindowLevel)windowLevel { }
- (void)setBackgroundColor: (UIColor *)backgroundColor { }
- (void)setUserInteractionEnabled: (BOOL)userInteractionEnabled { }


@end
