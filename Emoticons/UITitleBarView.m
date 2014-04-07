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
        _leftButtonAnimationStarted = NO;
        _rightButtonAnimationStarted = NO;
        self.backgroundColor = [UIColor colorWithWhite:0.98f alpha:1.0f];
        self.clipsToBounds = YES;
        
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

- (void)addButtonToLeft:(UITitleBarButton *)button
{
    [button setX:0.0f];
    [button setY:-44.0f];
    [button setHidden:YES];
    _leftButton = button;
    [self addSubview:button];
}

- (void)addButtonToRight:(UITitleBarButton *)button
{
    [button setX:self.frame.size.width - button.frame.size.width];
    [button setY:-44.0f];
    [button setHidden:YES];
    _rightButton = button;
    [self addSubview:button];
}

- (void)showRightButton
{
    [_rightButton setHidden:NO];
    [_rightButton setY:0.0f];
}

- (void)showRightButtonWithDuration:(CGFloat)duration
{
    if(_rightButton && _rightButton.hidden && !_rightButtonAnimationStarted){
        _rightButtonAnimationStarted = YES;
        [_rightButton setHidden:NO];
        [_rightButton setAlpha:0.0f];
        __block UITitleBarView* _self = self;
        [UIView animateWithDuration:duration / 2.0f
                         animations:^{
                             [_self.rightButton setY:-22.0f];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:duration / 2.0f
                                              animations:^{
                                                  [_self.rightButton setY:0.0f];
                                                  [_self.rightButton setAlpha:1.0f];
                                              }
                                              completion:^(BOOL finished){
                                                  _self.rightButtonAnimationStarted = NO;
                                              }];
                         }];
    }
}

- (void)showLeftButton
{
    [_leftButton setHidden:NO];
    [_leftButton setY:0.0f];
}

- (void)showLeftButtonWithDuration:(CGFloat)duration
{
    if(_leftButton && _leftButton.hidden && !_leftButtonAnimationStarted){
        _leftButtonAnimationStarted = YES;
        [_leftButton setHidden:NO];
        [_leftButton setAlpha:0.0f];
        __block UITitleBarView* _self = self;
        [UIView animateWithDuration:duration / 2.0f
                         animations:^{
                             [_self.leftButton setY:-22.0f];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:duration / 2.0f
                                              animations:^{
                                                  [_self.leftButton setY:0.0f];
                                                  [_self.leftButton setAlpha:1.0f];
                                              }
                                              completion:^(BOOL finished){
                                                  _self.leftButtonAnimationStarted = NO;
                                              }];
                         }];
    }
}

- (void)hideRightButton
{
    [_rightButton setHidden:YES];
    [_rightButton setY:-44.0f];
}

- (void)hideRightButtonWithDuration:(CGFloat)duration
{
    if(_rightButton && !_rightButton.hidden && !_rightButtonAnimationStarted){
        _rightButtonAnimationStarted = YES;
        [_rightButton setY:0.0f];
        __block UITitleBarView* _self = self;
        [UIView animateWithDuration:duration / 2.0f
                         animations:^{
                             [_self.rightButton setY:-22.0f];
                             [_self.rightButton setAlpha:0.0f];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:duration / 2.0f
                                              animations:^{
                                                  [_self.rightButton setY:-44.0f];
                                              }
                                              completion:^(BOOL finished){
                                                  [_self.rightButton setHidden:YES];
                                                  _self.rightButtonAnimationStarted = NO;
                                              }];
                         }];
    }
}

- (void)hideLeftButton
{
    [_leftButton setHidden:YES];
    [_leftButton setY:-44.0f];
}

- (void)hideLeftButtonWithDuration:(CGFloat)duration
{
    if(_leftButton && !_leftButton.hidden && !_leftButtonAnimationStarted){
        _leftButtonAnimationStarted = YES;
        [_leftButton setY:0.0f];
        __block UITitleBarView* _self = self;
        [UIView animateWithDuration:duration
                         animations:^{
                             [_self.leftButton setY:-22.0f];
                             [_self.leftButton setAlpha:0.0f];
                         }
                         completion:^(BOOL finished){
                             [UIView animateWithDuration:duration / 2.0f
                                              animations:^{
                                                  [_self.leftButton setY:-44.0f];
                                              }
                                              completion:^(BOOL finished){
                                                  [_self.leftButton setHidden:YES];
                                                  _self.leftButtonAnimationStarted = NO;
                                              }];
                         }];
    }
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
