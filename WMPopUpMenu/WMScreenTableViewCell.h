//
//  WMScreenTableViewCell.h
//  微猫商户端
//
//  Created by 冯文秀 on 16/11/21.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WMScreenTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UIView *screenBgView;

- (void)configreSubScreenCell:(NSString *)screenStr isSelected:(BOOL)isSelected;

- (void)configreSubScreenCell:(NSString *)screenStr;
@end
