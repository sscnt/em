//
//  UIEditorView.h
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEditorTextboxView.h"

@protocol UIEditorViewDelegate <NSObject>

- (void)backButtonDidPress;

@end

@interface UIEditorView : UIView <UIEditorTextboxViewDelegate>
{
    UIEditorTextboxView* _textBoxView;
    BOOL _keyboardShouldShow;
    CGFloat _keyboardHeight;
}

@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, weak) id<UIEditorViewDelegate> delegate;
@property (nonatomic, strong) NSString* placeholder;

- (void)showKeyboardIfNeeded;

- (void)keyboardWillShow:(NSNotification*)note;

@end
