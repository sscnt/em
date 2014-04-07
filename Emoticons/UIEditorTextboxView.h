//
//  UIEditorTextboxView.h
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITitleBarView.h"
#import "UITitleBarButton.h"
#import "UIEditorTextFieldView.h"

@protocol UIEditorTextboxViewDelegate <NSObject>

- (void)backButtonDidPress;

@end

@interface UIEditorTextboxView : UIView
{
    UITitleBarButton* _backButton;
    UITitleBarButton* _doneButton;
    UITitleBarView* _titleBarView;
    UIEditorTextFieldView* _textField;
}


@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, strong) UIView* view;
@property (nonatomic, weak) id<UIEditorTextboxViewDelegate> delegate;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, assign) CGSize visibleSize;

- (void)adjustLayout;
- (void)backButtonDidPress:(UITitleBarButton*)button;
- (void)showKeyboard;

@end
