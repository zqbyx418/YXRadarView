//
//  YXRadarIndictorView.h
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXRadarIndictorView : UIView

@property (nonatomic, assign) CGFloat radius;   // 半径
@property(nullable, nonatomic,strong) UIColor *startColor;  // 渐变开始颜色
@property(nullable, nonatomic,strong) UIColor *endColor;    // 渐变结束颜色
@property (nonatomic, assign) CGFloat angle;    // 扫描角度
@property (nonatomic, assign) BOOL clockwise;   // 是否顺时针

@end
