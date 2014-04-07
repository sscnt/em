//
//  UIEmoticonTableViewCell.m
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEmoticonTableViewCell.h"

@implementation UIEmoticonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.minimumFontSize = 12.0f;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    _highlighted = highlighted;
    [self setNeedsDisplay];
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

- (void)drawRect:(CGRect)rect
{
    
    if(_highlighted){
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rect];
        [[UIColor whiteColor] setFill];
        [rectanglePath fill];
        
    }

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
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
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
