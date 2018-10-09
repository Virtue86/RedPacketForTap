//
//  ViewController.m
//  RedPackForTapAction
//
//  Created by Virtue on 2018/10/9.
//  Copyright © 2018年 none. All rights reserved.
//

#import "ViewController.h"
#import "LHTouchView.h"


@interface ViewController ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) CALayer *moveLayer;

@property (nonatomic,strong) LHTouchView *touchView; // 自定义指定范围的红包
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"我可以点击" forState:0];
    [btn setBackgroundColor:[UIColor yellowColor]];
    btn.frame = CGRectMake(100, 100, 60, 30);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [self.view addSubview:self.touchView];
    [self startRedPackerts];
}

- (void)btnAction {
    NSLog(@"事件结果请查看log");
}

- (void)startRedPackerts
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1/4.0) target:self selector:@selector(showRain) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)showRain
{
    UIImageView * imageV = [UIImageView new];
    imageV.image = [UIImage imageNamed:@"redpacket"];
    imageV.frame = CGRectMake(0, -80, 44 , 62.5 );
    [self.touchView addSubview:imageV];
    [self addAnimationWithImagV:imageV];
}

- (void)addAnimationWithImagV:(UIImageView *)imageV {
    
    CAKeyframeAnimation * moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.duration = 60;
    NSValue * A = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, 0)];
    NSValue * B = [NSValue valueWithCGPoint:CGPointMake(arc4random() % 414, self.view.frame.size.height)];
    moveAnimation.values = @[A,B];
    moveAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
    moveAnimation.repeatCount = 1;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [imageV.layer addAnimation:moveAnimation forKey:nil];
    
    CAKeyframeAnimation * tranAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D r0 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
    CATransform3D r1 = CATransform3DMakeRotation(M_PI/180 * (arc4random() % 360 ) , 0, 0, -1);
    tranAnimation.values = @[[NSValue valueWithCATransform3D:r0],[NSValue valueWithCATransform3D:r1]];
    tranAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    tranAnimation.duration = arc4random() % 200 / 100.0 + 3.5;
    //为了避免旋转动画完成后再次回到初始状态。
    [tranAnimation setFillMode:kCAFillModeForwards];
    [tranAnimation setRemovedOnCompletion:NO];
    
    [imageV.layer addAnimation:tranAnimation forKey:nil];
}

- (void)clickRed:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.touchView];
    
    for (int i = 0 ; i < self.touchView.layer.sublayers.count ; i ++)
    {
        CALayer * layer = self.touchView.layer.sublayers[i];
        if ([[layer presentationLayer] hitTest:point] != nil)
        {
            UIImageView *edView = self.touchView.subviews[i];
            if (edView) {
                [edView removeFromSuperview];
            }
        
        }
        
    }
}


-(LHTouchView *)touchView {
    if (!_touchView) {
        _touchView = [[LHTouchView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
        _touchView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRed:)];
        [_touchView addGestureRecognizer:tap];
    }
    return _touchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
