//
//  YXRadarPointView.h
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXRadarPointViewDelegate;

@interface YXRadarPointView : UIView

@property(nullable, nonatomic,weak) id <YXRadarPointViewDelegate> delegate;

@end

@protocol YXRadarPointViewDelegate <NSObject>

@optional
- (void)didSelectItemRadarPointView:(nonnull YXRadarPointView *)radarPointView;   // 点击事件

@end
