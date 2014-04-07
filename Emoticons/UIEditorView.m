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
        _keyboardHeight = 216.0f;
        _keyboardShouldShow = YES;
        _textBoxView = [[UIEditorTextboxView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height - _keyboardHeight - 10.0f)];
        _textBoxView.delegate = self;
        [self addSubview:_textBoxView];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)setShadow:(BOOL)shadow
{
    _textBoxView.shadow = shadow;
}

- (void)showKeyboardIfNeeded
{
    if(_keyboardShouldShow){
        [_textBoxView showKeyboard];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    if([_textBoxView.text length] == 0){
        _keyboardShouldShow = YES;
        _textBoxView.text = placeholder;
    }else{
        _keyboardShouldShow = NO;
    }
}

#pragma mark keyboard

- (void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary* info = (NSDictionary*)[note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _keyboardHeight = kbSize.height;
    CGSize viewSize = CGSizeMake(self.frame.size.width, self.frame.size.height - _keyboardHeight - 10.0f);
    _textBoxView.visibleSize = viewSize;
}

#pragma mark delegate

- (void)backButtonDidPress
{
    [self endEditing:YES];
    [self.delegate backButtonDidPress];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
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
