//
//  YXRadarPointView.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "YXRadarPointView.h"

@implementation YXRadarPointView

#pragma mark - select point

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemRadarPointView:)]) {
            [self.delegate didSelectItemRadarPointView:self];
        }
    }
}

@end
