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
        _draggableEditorViewDefaultPosition = CGPointMake(_textBoxView.frame.origin.x, [_textBoxView bottom] +  (frame.size.height - _textBoxView.frame.size.height) / 2.0f);
        _draggableEmoticonView = [[UIEditorDraggableEmoticonView alloc] initWithFrame:CGRectMake(_draggableEditorViewDefaultPosition.x, _draggableEditorViewDefaultPosition.y, frame.size.width, 44.0f)];
        [self addSubview:_draggableEmoticonView];
        _draggableEmoticonView.hidden = YES;
        [self bringSubviewToFront:_draggableEmoticonView];
        
        //// Gesture
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDraggableEmoticonViewDrag:)];
        [_draggableEmoticonView addGestureRecognizer:panGestureRecognizer];
        
        _caretPoint = CGPointMake(0.0f, 0.0f);
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

- (void)resetPositionOfDraggableEmoticonView
{
    _draggableEmoticonView.userInteractionEnabled = NO;
    _draggableEmoticonView.shadow = NO;
    __block UIEditorView* _self = self;
    
    [UIView animateWithDuration:0.20f
                     animations:^{
                         _self.draggableEmoticonView.frame = CGRectMake(_self.draggableEditorViewDefaultPosition.x, _self.draggableEditorViewDefaultPosition.y, _self.draggableEmoticonView.frame.size.width, _draggableEmoticonView.frame.size.height);
                         _self.draggableEmoticonView.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         _self.draggableEmoticonView.userInteractionEnabled = YES;
                         _self.draggableEmoticonView.shadow = YES;
                     }];

    
}

#pragma mark keyboard

- (void)keyboardDidShow:(NSNotification *)note
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

#pragma mark draggable

- (void)didDraggableEmoticonViewDrag:(UIPanGestureRecognizer *)sender
{
    UIEditorDraggableEmoticonView *targetView = (UIEditorDraggableEmoticonView*)sender.view;
    CGPoint p = [sender translationInView:targetView];
    
    CGPoint movedPoint = CGPointMake(targetView.center.x + p.x, targetView.center.y + p.y);
    targetView.center = movedPoint;
    
    CGPoint fingerPoint = [sender locationInView:targetView];
    fingerPoint = CGPointMake(movedPoint.x - targetView.frame.size.width / 2.0f + fingerPoint.x, movedPoint.y - targetView.frame.size.height / 2.0f + fingerPoint.y);
    
    //// convert to box local
    CGFloat boxTop = _textBoxView.frame.origin.y + 44.0f;
    CGFloat boxLeft = _textBoxView.frame.origin.x;
    CGPoint boxLocal = CGPointMake(fingerPoint.x - boxLeft, fingerPoint.y - boxTop);
    
    //// shift
    CGPoint shiftedFingerPoint = CGPointMake(boxLocal.x, boxLocal.y - [CurrentSettings textSizeForEditor] * 5.0f);
    
    _textBoxView.fingerPoint = shiftedFingerPoint;
    
    
    if([_textBoxView isFingerOverTextField:boxLocal] || [_textBoxView isFingerOverTextField:shiftedFingerPoint]){
        [_textBoxView togglePreview:YES];
        NSString* insertText = ([CurrentSettings showCursorWhenDragging]) ? @"|" : _draggableEmoticonView.text;
        [_textBoxView previewTextWithInsertingText:insertText];
    }else{
        [_textBoxView togglePreview:NO];
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
        {
            targetView.shadow = NO;
            targetView.alpha = 0.30f;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [_textBoxView togglePreview:NO];
            if([_textBoxView isFingerOverTextField:boxLocal] || [_textBoxView isFingerOverTextField:shiftedFingerPoint]){
                if([_textBoxView insertText:_draggableEmoticonView.text AtPoint:shiftedFingerPoint]){
                    [_textBoxView showKeyboard];
                    _caretPoint = shiftedFingerPoint;
                }
            }
            [self resetPositionOfDraggableEmoticonView];
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        {
            [_textBoxView togglePreview:NO];
            [self resetPositionOfDraggableEmoticonView];
        }
            break;
        default:
            break;
    }
    
    
    [sender setTranslation:CGPointZero inView:targetView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    _textBoxView.delegate = nil;
}


@end
