//
//  UIEditorHintArrowView.m
//  Emoticons
//
//  Created by SSC on 2014/04/09.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorHintArrowView.h"

@implementation UIEditorHintArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    //// Color Declarations
    UIColor* color = [CurrentColor hintArrowColor];
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(72, 21)];
    [bezierPath addCurveToPoint: CGPointMake(78, 112) controlPoint1: CGPointMake(56.86, 43.36) controlPoint2: CGPointMake(64.11, 91.35)];
    [color setStroke];
    bezierPath.lineWidth = 2;
    CGFloat bezierPattern[] = {5, 5, 5, 5};
    [bezierPath setLineDash: bezierPattern count: 4 phase: 8];
    [bezierPath stroke];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(75.92, 27.65)];
    [bezier2Path addLineToPoint: CGPointMake(72.8, 19.21)];
    [bezier2Path addLineToPoint: CGPointMake(64.36, 22.33)];
    [color setStroke];
    bezier2Path.lineWidth = 2;
    [bezier2Path stroke];
    
    


}


@end
