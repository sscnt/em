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
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 3.0f;
        self.shadow = YES;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat paddingLeft = 20.0f;
        CGFloat paddingRight = 64.0f;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(paddingLeft, 0.0f, frame.size.width - paddingLeft - paddingRight, frame.size.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
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



- (NSString *)text
{
    return _textLabel.text;
}

- (void)setText:(NSString *)text
{
    _textLabel.text = text;
}

- (void)drawRect:(CGRect)rect
{
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: 3];
    [[CurrentColor draggableEmoticonViewBgColor] setFill];
    [roundedRectanglePath fill];
    
    
}


@end
