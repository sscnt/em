//
//  UIEditorDraggableEmoticonView.m
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorDraggableEmoticonView.h"

@implementation UIEditorDraggableEmoticonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        CGFloat padding = 20.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0.0f, frame.size.width - padding * 2.0f, frame.size.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
}

- (NSString *)text
{
    return _textLabel.text;
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;
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
