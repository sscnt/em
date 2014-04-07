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
        [_backButton addTarget:self.delegate action:@selector(backButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBarView addButtonToLeft:_backButton];
        [_titleBarView showLeftButton];
        
        //// Field
        _textField = [[UIEditorTextField alloc] initWithFrame:CGRectMake(0.0f, [_titleBarView bottom], frame.size.width, 60.0f)];
        [self.view addSubview:_textField];

    }
    return self;
}

- (void)setPlaceholder:(NSString *)text
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
