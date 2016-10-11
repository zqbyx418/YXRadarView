//
//  YXRadarIndictorView.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "YXRadarIndictorView.h"

@implementation YXRadarIndictorView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画扇形
    UIColor *startColor = self.startColor;
    CGContextSetFillColorWithColor(context, startColor.CGColor); // 填充颜色
    CGContextSetLineWidth(context, 0);  // 线宽
    CGContextMoveToPoint(context, self.center.x, self.center.y); // 圆心
    CGContextAddArc(context, self.center.x, self.center.y, self.radius, (self.clockwise?self.angle:0) * M_PI / 180, (self.clockwise?(self.angle - 1):1) * M_PI / 180, self.clockwise);  // 半径为 self.radius
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);  // 绘制
    
    const CGFloat *startColorComponents = CGColorGetComponents(self.startColor.CGColor);    //开始颜色的 RGB components
    const CGFloat *endColorComponents = CGColorGetComponents(self.endColor.CGColor);    //结束颜色的 RGB components
    
    CGFloat R, G, B, A;
    for (int i = 0; i <= self.angle; i++)
    {
        CGFloat ratio = (self.clockwise?(self.angle - i):i)/self.angle;
        R = startColorComponents[0] - (startColorComponents[0] - endColorComponents[0]) * ratio;
        G = startColorComponents[1] - (startColorComponents[1] - endColorComponents[1]) * ratio;
        B = startColorComponents[2] - (startColorComponents[2] - endColorComponents[2]) * ratio;
        A = startColorComponents[3] - (startColorComponents[3] - endColorComponents[3]) * ratio;
        
        UIColor *startColor = [UIColor colorWithRed:R green:G blue:B alpha:A];
        
        CGContextSetFillColorWithColor(context, startColor.CGColor);
        CGContextSetLineWidth(context, 0);
        CGContextMoveToPoint(context, self.center.x, self.center.y);
        CGContextAddArc(context, self.center.x, self.center.y, self.radius, i * M_PI / 180, (i + (self.clockwise?-1:1)) * M_PI / 180, self.clockwise);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
}

@end
