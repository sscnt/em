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
    UIEditorTextFieldView* _previewTextField;
}


@property (nonatomic, assign) BOOL shadow;
@property (nonatomic, strong) UIView* view;
@property (nonatomic, weak) id<UIEditorTextboxViewDelegate> delegate;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, assign) CGSize visibleSize;
@property (nonatomic, assign) CGPoint caretPoint;
@property (nonatomic, assign) CGPoint fingerPoint;

- (void)adjustLayout;
- (void)backButtonDidPress:(UITitleBarButton*)button;
- (void)showKeyboard;
- (void)togglePreview:(BOOL)show;
- (void)insertText:(NSString*)text AtPoint:(CGPoint)point;
- (NSMutableAttributedString*)textByInserteAtPoint:(CGPoint)point WithText:(NSString*)text;
- (void)previewTextWithInsertingText:(NSString*)text InsertAt:(CGPoint)point;
- (void)previewTextWithInsertingText:(NSString *)text;

@end
