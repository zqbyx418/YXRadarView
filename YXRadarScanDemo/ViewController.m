//
//  ViewController.m
//  YXRadarScanDemo
//
//  Created by bai on 16/10/10.
//  Copyright © 2016年 bai. All rights reserved.
//

#import "ViewController.h"
#import "YXRadarView.h"
#import "YXRadarIndictorView.h"

@interface ViewController () <YXRadarViewDelegate, YXRadarViewDateSource>
@property (nonatomic, weak) YXRadarView *radarView;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) CALayer *layer;
@end

@implementation ViewController

- (NSMutableArray *)pointsArray
{
    if (!_pointsArray) {
        _pointsArray = [NSMutableArray array];
    }
    return _pointsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupRadarView];
}

- (void)setupRadarView
{
    YXRadarView *radarView = [[YXRadarView alloc] initWithFrame:self.view.bounds];
    radarView.dataSource = self;
    radarView.delegate = self;
    radarView.radius = 200;
    radarView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    radarView.labelText = @"正在搜索附件的目标";
    [self.view addSubview:radarView];
    self.radarView = radarView;
    
    // 目标点位置
    [self randomPoints];
    [self.radarView scan];
    [self startUpdatingRadar];
}

#pragma mark - Custom Methods
- (void)startUpdatingRadar
{
    typeof(self) __weak weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.radarView.labelText = [NSString stringWithFormat:@"搜索已完成，共找到%lu个目标",(unsigned long)weakSelf.pointsArray.count];
        [weakSelf.radarView show];
    });
}

- (void)randomPoints
{
    [self.pointsArray removeAllObjects];
    int x, y;
    for (int  i = 0; i < 10; i++) {
        x = arc4random_uniform(400) - 200;
        y = arc4random_uniform(400) - 200;
        [self.pointsArray addObject:@[@(x),@(y)]];
    }
}

- (void)flickAnimationForPoints
{
        static CGFloat opacityNum = 0;
        BOOL ascending = YES;
        if (ascending) {
            opacityNum += 0.1;
            if (opacityNum >= 1) {
                ascending = NO;
            }
        }else{
            opacityNum -= 0.1;
            if (opacityNum <= 0.2) {
                ascending = YES;
            }
        }
        NSLog(@"%@----",[NSThread currentThread]);
        self.layer.opacity = opacityNum;
        [self.layer setNeedsDisplay];
    NSLog(@"%@", self.layer);
}

#pragma mark - BYXRadarViewDataSource
- (NSInteger)numberOfSectionsInRadarView:(YXRadarView *)radarView
{
    return 4;
}

- (NSInteger)numberOfPointsInRadarView:(YXRadarView *)radarView
{
    return [self.pointsArray count];
}

- (UIView *)radarView:(YXRadarView *)radarView viewForIndex:(NSUInteger)index
{
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    pointView.backgroundColor = [UIColor redColor];
    pointView.layer.cornerRadius = 2.5f;
//    YXFlickerPointView *point = [[YXFlickerPointView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
//    point.layer.cornerRadius = 2.5f;
//    point.backgroundColor = [UIColor redColor];
//    [pointView addSubview:point];
//    CALayer *layer = [CALayer layer];
//    self.layer = layer;
//    NSLog(@"%@================", self.layer);
//    layer.frame = CGRectMake(0, 0, 6, 6);
//    layer.backgroundColor = [UIColor redColor].CGColor;
//    layer.cornerRadius = 3.f;
//    layer.masksToBounds = YES;
//    [pointView.layer addSublayer:layer];
//    __block CGFloat opacityNum = 0;
//    __block BOOL ascending = YES;
//    if ([NSTimer instancesRespondToSelector:@selector(scheduledTimerWithTimeInterval:repeats:block:)]) {
//        // iOS10.0 API
//        if (!self.timer) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                if (ascending) {
//                    opacityNum += 0.1;
//                    if (opacityNum >= 1) {
//                        ascending = NO;
//                    }
//                }else{
//                    opacityNum -= 0.1;
//                    if (opacityNum <= 0.2) {
//                        ascending = YES;
//                    }
//                }
//                layer.opacity = opacityNum;
//            }];
//        }
//
//    } else {
//        if (!self.timer) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(flickAnimationForPoints) userInfo:nil repeats:YES];
//            
//        }
//    }
    
    return pointView;
}

- (CGPoint)radarView:(YXRadarView *)radarView positionForIndex:(NSUInteger)index
{
    NSArray *point = [self.pointsArray objectAtIndex:index];
    return CGPointMake([point[0] floatValue], [point[1] floatValue]);
}

#pragma mark - BYXRadarViewDelegate

- (void)radarView:(YXRadarView *)radarView didSelectItemAtIndex:(NSUInteger)index
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"didSelectItemAtiIndex:%lu",(unsigned long)index] message:[NSString stringWithFormat:@"%@",self.pointsArray[index]] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
