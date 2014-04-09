//
//  UIEditorView.h
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEditorTextboxView.h"
#import "UIEditorDraggableEmoticonView.h"
#import "UIEditorHintArrowView.h"

@protocol UIEditorViewDelegate <NSObject>

- (void)backButtonDidPress;

@end

@interface UIEditorView : UIView <UIEditorTextboxViewDelegate>
{
    UIEditorTextboxView* _textBoxView;
    BOOL _keyboardShouldShow;
    CGFloat _keyboardHeight;
    CGPoint _caretPoint;
}

@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, weak) id<UIEditorViewDelegate> delegate;
@property (nonatomic, strong) NSString* placeholder;
@property (nonatomic, strong) UIEditorDraggableEmoticonView* draggableEmoticonView;
@property (nonatomic, assign) CGPoint draggableEditorViewDefaultPosition;
@property (nonatomic, strong) UIEditorHintArrowView* hintArrowView;

- (void)showKeyboardIfNeeded;
- (void)keyboardDidShow:(NSNotification*)note;
- (void)showDraggableEmoticonViewWithText:(NSString*)text;
- (void)didDraggableEmoticonViewDrag:(UIPanGestureRecognizer *)sender;
- (void)resetPositionOfDraggableEmoticonView;

@end
