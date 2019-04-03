//
//  CWAsyncLabel.m
//  RookiePerformanceMonitor
//
//  Created by Jack Chen on 2018/11/6.
//  Copyright © 2018年 Jack Chen. All rights reserved.
//

#import "CWAsyncLabel.h"
#import <CoreText/CoreText.h>
#import "YYDispatchQueuePool+Block.h"

@implementation CWAsyncLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setText: (NSString *)text {
    if ([NSThread currentThread]) {
        CWDispatchQueueAsyncBlockInBackground(^{
              [self displayAttributedText: [[NSAttributedString alloc] initWithString: text attributes: @{ NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor }]];
        });
    }
    else
    {
        [self displayAttributedText: [[NSAttributedString alloc] initWithString: text attributes: @{ NSFontAttributeName: self.font, NSForegroundColorAttributeName: self.textColor }]];
    }
}

- (void)setAttributedText: (NSAttributedString *)attributedText {
    if ([NSThread currentThread]) {
        CWDispatchQueueAsyncBlockInBackground(^{
            [self displayAttributedText:attributedText];
        });
    }
    else
    {
        [self displayAttributedText:attributedText];
    }
}
- (void)displayAttributedText: (NSAttributedString *)attributedText {
    if (attributedText == nil) {
        attributedText = [NSMutableAttributedString new];
    } else if ([attributedText isMemberOfClass: [NSAttributedString class]]) {
        attributedText = attributedText.mutableCopy;
    }
    
    NSMutableParagraphStyle * style = [NSMutableParagraphStyle new];
    style.alignment = self.textAlignment;
    [((NSMutableAttributedString *)attributedText) addAttributes: @{ NSParagraphStyleAttributeName: style } range: NSMakeRange(0, attributedText.length)];
    
    CGSize size = self.frame.size;
    size.height += 10;
    /*
     图片上下文，图片上下文的绘制不需要在drawRect:方法中进行，在一个普通的OC方法中就可以绘制。
     * 参数一: 指定将来创建出来的bitmap的大小
     * 参数二: 设置透明YES代表透明，NO代表不透明
     * 参数三: 代表缩放,0代表不缩放
     */
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context != NULL) {
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        
        CGSize textSize = [attributedText.string boundingRectWithSize: size options: NSStringDrawingUsesLineFragmentOrigin attributes: @{ NSFontAttributeName: self.font } context: nil].size;
        textSize.width = ceil(textSize.width);
        textSize.height = ceil(textSize.height);
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake((size.width - textSize.width) / 2, 5, textSize.width, textSize.height));
        CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attributedText.length), path, NULL);
        CTFrameDraw(frame, context);
        
        UIImage * contents = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CFRelease(frameSetter);
        CFRelease(frame);
        CFRelease(path);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (id)contents.CGImage;
        });
    }
}
@end
