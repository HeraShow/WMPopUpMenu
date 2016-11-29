//
//  WMOLStyleTableViewCell.m
//  微猫商户端
//
//  Created by 冯文秀 on 16/11/18.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "WMOLStyleTableViewCell.h"

@implementation WMOLStyleTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.picImgView = [[UIImageView alloc]initWithFrame:CGRectMake(17, 20, 74 * KScreenWScale, 74 * KScreenWScale)];
        self.picImgView.backgroundColor = ColorRGB(234, 236, 239, 1);
        self.picImgView.layer.cornerRadius = 4 * KScreenWScale;
        self.picImgView.clipsToBounds = YES;
        [self.contentView addSubview:_picImgView];
        
        self.orderNoLab = [[UILabel alloc]initWithFrame:CGRectMake(33 + 74 * KScreenWScale, 20, KScreenWidth - 62 - 74 * KScreenWScale, 16)];
        self.orderNoLab.font = WMLightFont(12);
        self.orderNoLab.textColor = WMHPDark;
        self.orderNoLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_orderNoLab];
        
        self.receiveLab = [[UILabel alloc]initWithFrame:CGRectMake(33 + 74 * KScreenWScale, 12 + 37*KScreenWScale, KScreenWidth - 124 - 74 * KScreenWScale, 16)];
        self.receiveLab.font = WMLightFont(12);
        self.receiveLab.textColor = WMHPDark;
        self.receiveLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_receiveLab];
        
        self.ordersLabel = [[UILabel alloc]initWithFrame:CGRectMake(33 + 74 * KScreenWScale, 74 * KScreenWScale + 4, KScreenWidth - 64 - 74 * KScreenWScale, 16)];
        self.ordersLabel.font = WMLightFont(12);
        self.ordersLabel.textColor = WMHPDark;
        self.ordersLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_ordersLabel];
        
        self.orderStatuaLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth - 99, 37 * KScreenWScale + 12, 66, 16)];
        self.orderStatuaLab.font = WMLightFont(12);
        self.orderStatuaLab.textColor = WMLogoutBg;
        self.orderStatuaLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_orderStatuaLab];
        
        self.enterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth - 26, 37 * KScreenWScale + 12, 10, 16)];
        self.enterImgView.image = [UIImage imageNamed:@"wemart_enter"];
        [self.contentView addSubview:_enterImgView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39.5 + 74 * KScreenWScale, KScreenWidth, 0.5)];
        lineView.backgroundColor = WMLineColor;
        [self.contentView addSubview:lineView];
    }
    return self;
}

#pragma mark --- 订单列表 ---
- (void)configureOrderFormCell
{
    self.orderNoLab.text = [NSString stringWithFormat:@"订单编号: %@", @1234567890];
    self.receiveLab.text = [NSString stringWithFormat:@"收货人: %@", @"receiver"];
    self.ordersLabel.text = [NSString stringWithFormat:@"下单时间: %@", @"2016-11-29 18:01:08"];
    self.orderStatuaLab.text = @"未发货";
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
