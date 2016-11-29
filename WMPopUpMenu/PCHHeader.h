//
//  PCHHeader.h
//  WMPopUpMenu
//
//  Created by 冯文秀 on 16/11/29.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#ifndef PCHHeader_h
#define PCHHeader_h
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWScale (KScreenWidth / 375.f)
#define KScreenHScale (KScreenHeight / 667.f)

#define ColorRGB(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]
#define WMSearchBarBg ColorRGB(247, 248, 250, 1)
#define WMLineColor ColorRGB(195, 198, 198, 1)
#define WMContent2Color ColorRGB(83, 89, 89, 1)
#define WMContent3Color ColorRGB(140, 144, 145, 1)
#define WMShopBg ColorRGB(240, 243, 245, 1)
#define WMHPDark ColorRGB(55, 59, 64, 1)
#define WMBlueColor ColorRGB(16, 169, 235, 1)
#define WMLogoutBg ColorRGB(238, 84, 41, 1)

// 细体
#define WMLightFont(FontSize) [UIFont fontWithName:@"PingFangSC-Light" size:FontSize]
// 粗体
#define WMBoldFont(FontSize) [UIFont fontWithName:@"PingFangSC-Bold" size:FontSize]
// 中等
#define WMMediumFont(FontSize) [UIFont fontWithName:@"PingFangSC-Medium" size:FontSize]
// 常规
#define WMRegularFont(FontSize) [UIFont fontWithName:@"PingFangSC-Regular" size:FontSize]

#endif /* PCHHeader_h */
