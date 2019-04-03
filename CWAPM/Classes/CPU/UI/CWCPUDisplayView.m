//
//  CWCPUDisplayView.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWCPUDisplayView.h"
#import "CWAsyncLabel.h"
#import "YYDispatchQueuePool+Block.h"
@interface CWCPUDisplayView()

@property(nonatomic,strong)CWAsyncLabel* displayerLabel;
@end
@implementation CWCPUDisplayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame: (CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        CAShapeLayer * bgLayer = [CAShapeLayer layer];
        bgLayer.fillColor = [UIColor colorWithWhite: 0 alpha: 0.7].CGColor;
        bgLayer.path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) cornerRadius: 5].CGPath;
        [self.layer addSublayer: bgLayer];
        
        self.displayerLabel = [[CWAsyncLabel alloc] initWithFrame: self.bounds];
        self.displayerLabel.textColor = [UIColor whiteColor];
        self.displayerLabel.textAlignment = NSTextAlignmentCenter;
        self.displayerLabel.font = [UIFont fontWithName: @"Menlo" size: 14];
        [self addSubview: self.displayerLabel];
    }
    return self;
}

- (void)displayCPUUsage: (double)fusage
{
    NSInteger usage=fusage;
    CWDispatchQueueAsyncBlockInDefault(^{
        NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithString: @"CPU" attributes: @{ NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: _displayerLabel.font }];
        [attributed appendAttributedString: [[NSAttributedString alloc] initWithString: [NSString stringWithFormat: @"%ld%%", usage] attributes: @{ NSFontAttributeName: _displayerLabel.font, NSForegroundColorAttributeName: [UIColor colorWithHue: 0.27 * (0.8 - (usage / 100.)) saturation: 1 brightness: 0.9 alpha: 1] }]];
        self.displayerLabel.attributedText = attributed;
    });
}
@end
