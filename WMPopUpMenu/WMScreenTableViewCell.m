//
//  WMScreenTableViewCell.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/11/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMScreenTableViewCell.h"

@implementation WMScreenTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WMSearchBarBg;
        
        self.screenBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2 - 14, 30)];
        [self.contentView addSubview:_screenBgView];
        
        self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/4 - 38, 6, 63, 18)];
        self.hintLabel.font = WMLightFont(12);
        self.hintLabel.textColor = WMContent2Color;
        self.hintLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_hintLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(30, 29.5, KScreenWidth/2 - 75.5, 0.5)];
        lineView.backgroundColor = WMLineColor;
        [self.contentView addSubview:lineView];
    }
    return self;
}

- (void)configreSubScreenCell:(NSString *)screenStr isSelected:(BOOL)isSelected
{
    self.hintLabel.text = screenStr;
    if (isSelected) {
        self.hintLabel.textColor = WMBlueColor;
    }
    else{
        self.hintLabel.textColor = WMContent2Color;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
