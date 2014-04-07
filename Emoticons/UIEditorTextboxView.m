//
//  UIEditorTextboxView.m
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorTextboxView.h"

@implementation UIEditorTextboxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _view.layer.masksToBounds = YES;
        _view.layer.cornerRadius = 3.0f;
        [self addSubview:_view];
        
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = NO;
        self.shadow = YES;
        
        //// Title
        _titleBarView = [[UITitleBarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, 44.0f)];
        [_titleBarView setTitle:NSLocalizedString(@"Text", nil)];
        [self.view addSubview:_titleBarView];
        
        //////// Back
        _backButton = [[UITitleBarButton alloc] initWithType:UITitleBarButtonTypeBack];
        [_backButton addTarget:self.delegate action:@selector(backButtonDidPress) forControlEvents:UIControlEventTouchUpInside];
        [_titleBarView addButtonToLeft:_backButton];
        [_titleBarView showLeftButton];
        
        //// Field
        _textField = [[UIEditorTextFieldView alloc] initWithFrame:CGRectMake(0.0f, [_titleBarView bottom], frame.size.width, frame.size.height - 88.0f)];
        _textField.text = @"";
        [self.view addSubview:_textField];

    }
    return self;
}

- (void)setCaretPoint:(CGPoint)caretPoint
{
    UITextPosition * position = [_textField closestPositionToPoint:caretPoint];
    [_textField setSelectedTextRange:[_textField textRangeFromPosition:position toPosition:position]];
}

- (void)insertText:(NSString *)text AtPoint:(CGPoint)point
{
    UITextPosition * position = [_textField closestPositionToPoint:point];
    [_textField setSelectedTextRange:[_textField textRangeFromPosition:position toPosition:position]];
    NSRange range = _textField.selectedRange;
    NSString * firstHalfString = [_textField.text substringToIndex:range.location];
    NSString * secondHalfString = [_textField.text substringFromIndex: range.location];
    _textField.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    
    _textField.text = [NSString stringWithFormat: @"%@%@%@", firstHalfString, text, secondHalfString];
    range.location += [text length];
    _textField.selectedRange = range;
    _textField.scrollEnabled = YES;
}

- (void)setVisibleSize:(CGSize)visibleSize
{
    _visibleSize = visibleSize;
    [self adjustLayout];
}

- (void)adjustLayout
{
    [self setHeight:_visibleSize.height];
    [_textField setHeight:_visibleSize.height - 88.0f];
}

- (void)showKeyboard
{
    LOG(@"keyboard show");
    [_textField becomeFirstResponder];
}

- (NSString *)text
{
    return _textField.text;
}

- (void)setText:(NSString *)text
{
    _textField.text = text;
}

- (void)setShadow:(BOOL)shadow
{
    if(shadow){
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.7f;
        self.layer.shadowColor = [CurrentColor dropshadowColor].CGColor;
        self.layer.shadowRadius = 4.0f;
    }else{
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowOpacity = 0.0f;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0.0f;
    }
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
