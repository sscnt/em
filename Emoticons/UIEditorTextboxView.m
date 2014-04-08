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
        
        //// Preview
        _previewTextField = [[UIEditorTextFieldView alloc] initWithFrame:_textField.frame];
        _previewTextField.text = @"";
        _previewTextField.editable = NO;
        _previewTextField.hidden = NO;
        _previewTextField.userInteractionEnabled = NO;
        _previewTextField.hidden = YES;
        [self.view addSubview:_previewTextField];

    }
    return self;
}

- (void)setCaretPoint:(CGPoint)caretPoint
{
    UITextPosition * position = [_textField closestPositionToPoint:caretPoint];
    [_textField setSelectedTextRange:[_textField textRangeFromPosition:position toPosition:position]];
}

- (void)togglePreview:(BOOL)show
{
    _previewTextField.hidden = !show;
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

- (NSMutableAttributedString *)textByInserteAtPoint:(CGPoint)point WithText:(NSString *)text
{
    UITextPosition * position = [_textField closestPositionToPoint:point];
    [_textField setSelectedTextRange:[_textField textRangeFromPosition:position toPosition:position]];
    NSRange range = _textField.selectedRange;
    NSString * firstHalfString = [_textField.text substringToIndex:range.location];
    NSString * secondHalfString = [_textField.text substringFromIndex: range.location];
    
    
    NSDictionary *stringAttributes1 = @{ NSForegroundColorAttributeName : [CurrentColor normalTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16.0f] };
    NSAttributedString *string1 = [[NSAttributedString alloc] initWithString:firstHalfString attributes:stringAttributes1];
    
    NSDictionary *stringAttributes2 = @{ NSForegroundColorAttributeName : [CurrentColor activeTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16.0f] };
    NSAttributedString *string2 = [[NSAttributedString alloc] initWithString:text attributes:stringAttributes2];
    
    NSDictionary *stringAttributes3 = @{ NSForegroundColorAttributeName : [CurrentColor normalTextColor], NSFontAttributeName : [UIFont systemFontOfSize:16.0f] };
    NSAttributedString *string3 = [[NSAttributedString alloc] initWithString:secondHalfString attributes:stringAttributes3];
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];
    [mutableAttributedString appendAttributedString:string1];
    [mutableAttributedString appendAttributedString:string2];
    [mutableAttributedString appendAttributedString:string3];
    return mutableAttributedString;
}

- (void)previewTextWithInsertingText:(NSString *)text InsertAt:(CGPoint)point
{
    _previewTextField.attributedText = [self textByInserteAtPoint:point WithText:text];
}

- (void)previewTextWithInsertingText:(NSString *)text
{
    [self previewTextWithInsertingText:text InsertAt:_fingerPoint];
    
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

- (void)setFingerPoint:(CGPoint)fingerPoint
{
    //// convert to field local
    CGPoint fieldLocal = CGPointMake(_textField.contentOffset.x + fingerPoint.x, _textField.contentOffset.y + fingerPoint.y);
    _fingerPoint = fieldLocal;
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
