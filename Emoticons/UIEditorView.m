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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        //// Draggable
        _draggableEmoticonView = [[UIEditorDraggableEmoticonView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 84.0f, frame.size.width, 44.0f)];
        [self addSubview:_draggableEmoticonView];
        _draggableEmoticonView.hidden = YES;
        [self bringSubviewToFront:_draggableEmoticonView];
        
        //// Gesture
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDraggableEmoticonViewDrag:)];
        [_draggableEmoticonView addGestureRecognizer:panGestureRecognizer];

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
        [self showDraggableEmoticonViewWithText:placeholder];
    }
}

- (void)showDraggableEmoticonViewWithText:(NSString *)text
{
    _keyboardShouldShow = NO;
    _draggableEmoticonView.hidden = NO;
    _draggableEmoticonView.text = text;
}

#pragma mark keyboard

- (void)keyboardDidShow:(NSNotification *)note
{
    NSDictionary* info = (NSDictionary*)[note userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    _keyboardHeight = kbSize.height;
    CGSize viewSize = CGSizeMake(self.frame.size.width, self.frame.size.height - _keyboardHeight - 10.0f);
    _textBoxView.visibleSize = viewSize;
    
    _textBoxView.caretPoint = CGPointMake(20.0f, _textBoxView.frame.size.height + 10.0f);
}

#pragma mark delegate

- (void)backButtonDidPress
{
    [self endEditing:YES];
    [self.delegate backButtonDidPress];
}

#pragma mark draggable

- (void)didDraggableEmoticonViewDrag:(UIPanGestureRecognizer *)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            [_textBoxView togglePreview:YES];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            [_textBoxView togglePreview:NO];
        }
            break;
        default:
            break;
    }
    UIView *targetView = sender.view;
    CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = CGPointMake(targetView.center.x + p.x, targetView.center.y + p.y);
    targetView.center = movedPoint;
    
    CGPoint fingerPoint = [sender locationInView:targetView];
    fingerPoint = CGPointMake(movedPoint.x - targetView.frame.size.width / 2.0f + fingerPoint.x, movedPoint.y - targetView.frame.size.height / 2.0f + fingerPoint.y);
    
    //// convert to box local
    CGFloat boxTop = _textBoxView.frame.origin.y + 44.0f;
    CGFloat boxLeft = _textBoxView.frame.origin.x;
    CGPoint boxLocal = CGPointMake(fingerPoint.x - boxLeft, fingerPoint.y - boxTop);
    _textBoxView.fingerPoint = boxLocal;
    [_textBoxView previewTextWithInsertingText:_draggableEmoticonView.text];
    
    [sender setTranslation:CGPointZero inView:targetView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    _textBoxView.delegate = nil;
}


@end
