//
//  UICategoryTableViewCell.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UICategoryTableViewCell.h"

@implementation UICategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.clipsToBounds = YES;
        if([UIDevice isCurrentLanguageJapanese]) {
            self.textLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
            if([UIDevice isIOS6]){
                
            }else{
                
            }
        } else {
            self.textLabel.font = [UIFont fontWithName:@"SheepSansBold" size:18.0f];
            if([UIDevice isIOS6]){
                
            }else{
                
            }
        }

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    _highlighted = highlighted;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* arrowColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.70f];
    
    if(_highlighted){
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
        [[UIColor whiteColor] setFill];
        [rectanglePath fill];
        
        arrowColor = [CurrentColor activeTextColor];
    }
 
    //// Arrow
    CGFloat arrowOffsetX = rect.size.width - 44.0f;
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(arrowOffsetX + 21.83, 22)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 16.88, 17.05)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 19, 14.93)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 26.07, 22)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 19, 29.07)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 16.88, 26.95)];
    [bezierPath addLineToPoint: CGPointMake(arrowOffsetX + 21.83, 22)];
    [bezierPath closePath];
    [arrowColor setFill];
    [bezierPath fill];
    
    

    
    

    
    if (!_isTopCell) {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.0f, 0.5f)];
        [bezierPath addLineToPoint: CGPointMake(rect.size.width, 0.5f)];
        [[CurrentColor cellLightBorderColor] setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
    
    //// Bezier Drawing
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(0.0f, rect.size.height)];
    [bezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height)];
    [[CurrentColor cellDarkBorderColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    if(_isBottomCell){
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.0f, rect.size.height + 0.50f)];
        [bezierPath addLineToPoint: CGPointMake(rect.size.width, rect.size.height + 0.50f)];
        [[CurrentColor cellLightBorderColor] setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
}

@end
