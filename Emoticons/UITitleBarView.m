//
//  UITitleBarView.m
//  Emoticons
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UITitleBarView.h"

@implementation UITitleBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.98f alpha:1.0f];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _titleLabel.alpha = 0.9f;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
        _titleLabel.numberOfLines = 0;
        if([UIDevice isCurrentLanguageJapanese]) {
            _titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
            if([UIDevice isIOS6]){
                _titleLabel.center = CGPointMake(_titleLabel.center.x, _titleLabel.center.y + 1.0f);
            }else{
                
            }
        } else {
            _titleLabel.font = [UIFont fontWithName:@"SheepSansBold" size:18.0f];
            if([UIDevice isIOS6]){
                
            }else{
                _titleLabel.center = CGPointMake(_titleLabel.center.x, _titleLabel.center.y + 1.0f);
            }
        }
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)drawRect:(CGRect)rect
{
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 3.0f, rect.size.width, 0.5)];
    [[UIColor whiteColor] setFill];
    [rectanglePath fill];
    
    //// Rectangle Drawing
    rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 2.5f, rect.size.width, 2.0f)];
    [[CurrentColor titleBarShadowColor] setFill];
    [rectanglePath fill];
    
    //// Rectangle Drawing
    rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.0f, rect.size.height - 0.50f, rect.size.width, 0.5)];
    [[CurrentColor titleBarBorderColor] setFill];
    [rectanglePath fill];
}

@end
