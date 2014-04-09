//
//  UIEditorDraggableEmoticonView.m
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorDraggableEmoticonView.h"

@implementation UIEditorDraggableEmoticonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 3.0f;
        self.shadow = YES;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat paddingLeft = 20.0f;
        CGFloat paddingRight = 64.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0.0f, frame.size.width - paddingLeft - paddingRight, frame.size.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
}


- (void)setShadow:(BOOL)shadow
{
    if(shadow){
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.7f;
        self.layer.shadowColor = [CurrentColor dropshadowColor].CGColor;
        self.layer.shadowRadius = 4.0f;
    }else{
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.0f;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0.0f;
    }
}



- (NSString *)text
{
    return _textLabel.text;
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;
}

- (void)drawRect:(CGRect)rect
{
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: 3];
    [[CurrentColor draggableEmoticonViewBgColor] setFill];
    [roundedRectanglePath fill];
    
    //// Color Declarations
    UIColor* color = [CurrentColor draggableEmoticonViewKnobColor];
    UIColor* color2 = [CurrentColor draggableEmoticonViewKnobShadowColor];
    
    CGFloat x = rect.size.width - 49.0f;
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(x + 14, 22, 18, 2)];
    [color setFill];
    [rectanglePath fill];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(x + 13, 21)];
    [bezierPath addLineToPoint: CGPointMake(x + 32, 21)];
    [bezierPath addLineToPoint: CGPointMake(x + 32, 22)];
    [bezierPath addLineToPoint: CGPointMake(x + 14, 22)];
    [bezierPath addLineToPoint: CGPointMake(x + 14, 24)];
    [bezierPath addLineToPoint: CGPointMake(x + 13, 24)];
    [bezierPath addLineToPoint: CGPointMake(x + 13, 21)];
    [bezierPath closePath];
    [color2 setFill];
    [bezierPath fill];
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(x + 14, 29, 18, 2)];
    [color setFill];
    [rectangle2Path fill];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(x + 13, 28)];
    [bezier2Path addLineToPoint: CGPointMake(x + 32, 28)];
    [bezier2Path addLineToPoint: CGPointMake(x + 32, 29)];
    [bezier2Path addLineToPoint: CGPointMake(x + 14, 29)];
    [bezier2Path addLineToPoint: CGPointMake(x + 14, 31)];
    [bezier2Path addLineToPoint: CGPointMake(x + 13, 31)];
    [bezier2Path addLineToPoint: CGPointMake(x + 13, 28)];
    [bezier2Path closePath];
    [color2 setFill];
    [bezier2Path fill];
    
    
    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(x + 14, 15, 18, 2)];
    [color setFill];
    [rectangle3Path fill];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(x + 13, 14)];
    [bezier3Path addLineToPoint: CGPointMake(x + 32, 14)];
    [bezier3Path addLineToPoint: CGPointMake(x + 32, 15)];
    [bezier3Path addLineToPoint: CGPointMake(x + 14, 15)];
    [bezier3Path addLineToPoint: CGPointMake(x + 14, 17)];
    [bezier3Path addLineToPoint: CGPointMake(x + 13, 17)];
    [bezier3Path addLineToPoint: CGPointMake(x + 13, 14)];
    [bezier3Path closePath];
    [color2 setFill];
    [bezier3Path fill];
    
    
    

}


@end
