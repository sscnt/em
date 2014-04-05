//
//  UICategoryTableViewCell.m
//  Emoticons
//
//  Created by SSC on 2014/04/04.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UICategoryTableViewCell.h"

@implementation UICategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if([UIDevice isCurrentLanguageJapanese]) {
            self.textLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
            if([UIDevice isIOS6]){
                
            }else{
                
            }
        } else {
            self.textLabel.font = [UIFont fontWithName:@"SheepSansBold" size:18.0f];
            if([UIDevice isIOS6]){
                
            }else{
                
            }
        }

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
