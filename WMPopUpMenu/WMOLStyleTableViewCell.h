//
//  WMOLStyleTableViewCell.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/11/18.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WMOLStyleTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *picImgView;
@property (nonatomic, strong) UILabel *orderNoLab;
@property (nonatomic, strong) UILabel *receiveLab;
@property (nonatomic, strong) UILabel *ordersLabel;
@property (nonatomic, strong) UILabel *orderStatuaLab;
@property (nonatomic, strong) UIImageView *enterImgView;
// 订单列表 返回cell
- (void)configureOrderFormCell;

@end
