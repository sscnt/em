//
//  UIEditorDraggableEmoticonView.h
//  Emoticons
//
//  Created by SSC on 2014/04/07.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIEditorDraggableEmoticonView : UIView
{
    UILabel* _textLabel;
}

@property (nonatomic, strong) NSString* text;

@end
