//
//  CWFPSDisplay.m
//  CWPerformanceMonitor
//
//  Created by Jack Chen on 2018/11/8.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWFPSDisplayView.h"
#import "CWAsyncLabel.h"
#import "YYDispatchQueuePool+Block.h"



@interface CWFPSDisplayView()
@property(nonatomic,strong)CWAsyncLabel* displayerLabel;
@end
@implementation CWFPSDisplayView

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
        bgLayer.path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 60, 20) cornerRadius: 5].CGPath;
        [self.layer addSublayer: bgLayer];
        
        self.displayerLabel = [[CWAsyncLabel alloc] initWithFrame: self.bounds];
        self.displayerLabel.textColor = [UIColor whiteColor];
        self.displayerLabel.textAlignment = NSTextAlignmentCenter;
        self.displayerLabel.font = [UIFont fontWithName: @"Menlo" size: 14];
        [self updateFPS: 60];
        [self addSubview: self.displayerLabel];
    }
    return self;
}
- (void)updateFPS: (int)fps
{
    CWDispatchQueueAsyncBlockInDefault(^{
        NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat: @"%d", fps] attributes: @{ NSForegroundColorAttributeName: [UIColor colorWithHue: 0.27 * (fps / 60.0 - 0.2) saturation: 1 brightness: 0.9 alpha: 1], NSFontAttributeName: _displayerLabel.font }];
        [attributed appendAttributedString: [[NSAttributedString alloc] initWithString: @"FPS" attributes: @{ NSFontAttributeName: _displayerLabel.font, NSForegroundColorAttributeName: [UIColor whiteColor] }]];
        self.displayerLabel.attributedText = attributed;
    });
}
@end
