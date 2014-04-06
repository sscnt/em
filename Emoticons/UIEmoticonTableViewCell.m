//
//  UIEmoticonTableViewCell.m
//  Emoticons
//
//  Created by SSC on 2014/04/06.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEmoticonTableViewCell.h"

@implementation UIEmoticonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textAlignment = UITextAlignmentCenter;
        self.textLabel.font = [UIFont systemFontOfSize:16.0f];
        self.textLabel.minimumFontSize = 12.0f;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
