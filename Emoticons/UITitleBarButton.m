//
//  UITitleBarButton.m
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UITitleBarButton.h"

@implementation UITitleBarButton

- (id)initWithType:(UITitleBarButtonType)type
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _type = type;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    switch (_type) {
        case UITitleBarButtonTypeBack:
            [self drawRectTypeBack:rect];
            break;
        case UITitleBarButtonTypeSettings:
            break;
        default:
            break;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

#pragma mark type back

- (void)drawRectTypeBack:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.80f];
    if(_highlighted){
        color = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    }
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(17.76, 22)];
    [bezierPath addLineToPoint: CGPointMake(24.12, 28.36)];
    [bezierPath addLineToPoint: CGPointMake(22, 30.49)];
    [bezierPath addLineToPoint: CGPointMake(13.51, 22)];
    [bezierPath addLineToPoint: CGPointMake(22, 13.51)];
    [bezierPath addLineToPoint: CGPointMake(24.12, 15.64)];
    [bezierPath addLineToPoint: CGPointMake(17.76, 22)];
    [bezierPath closePath];
    [color setFill];
    [bezierPath fill];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPath];
    [rectanglePath moveToPoint: CGPointMake(16, 23.5)];
    [rectanglePath addLineToPoint: CGPointMake(31, 23.5)];
    [rectanglePath addLineToPoint: CGPointMake(31, 20.5)];
    [rectanglePath addLineToPoint: CGPointMake(16, 20.5)];
    [rectanglePath addLineToPoint: CGPointMake(16, 23.5)];
    [rectanglePath closePath];
    [color setFill];
    [rectanglePath fill];
}


@end
