//
//  LHTouchView.m
//  RedPackForTapAction
//
//  Created by Virtue on 2018/10/9.
//  Copyright © 2018年 none. All rights reserved.
//

#import "LHTouchView.h"

@implementation LHTouchView
// 制定可点击的范围
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    for (int i = 0 ; i < self.layer.sublayers.count ; i ++)
    {
        CALayer * layer = self.layer.sublayers[i];
        if ([[layer presentationLayer] hitTest:point] != nil)
        {
            UIImageView *edView = self.subviews[i];
            if (edView) {
                return self;
            }
        }
        
    }
    return nil;
}

@end
