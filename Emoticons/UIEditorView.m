//
//  UIEditorView.m
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorView.h"

@implementation UIEditorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textBoxView = [[UIEditorTextboxView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 300.0f)];
        _textBoxView.delegate = self;
        [self addSubview:_textBoxView];
    }
    return self;
}

- (void)setShadow:(BOOL)shadow
{
    _textBoxView.shadow = shadow;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [_textBoxView setPlaceholder:placeholder];
}

#pragma mark delegate

- (void)backButtonDidPress:(UITitleBarButton *)button
{
    [self endEditing:YES];
    [self.delegate backButtonDidPress];
}

- (void)dealloc
{
    _textBoxView.delegate = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
