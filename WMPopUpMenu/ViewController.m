//
//  ViewController.m
//  WMPopUpMenu
//
//  Created by 冯文秀 on 16/11/29.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "ViewController.h"
#import "WMOLStyleTableViewCell.h"
#import "WMScreenTableViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *orderTabView;

@property (nonatomic, strong) UITableView *orderTypeTabView;
@property (nonatomic, strong) NSArray *orderTypeArray;
@property (nonatomic, strong) UITableView *orderTimeTabView;
@property (nonatomic, strong) NSArray *orderTimeArray;

@property (nonatomic, assign) NSInteger typeIndex;
@property (nonatomic, assign) NSInteger timeIndex;
@property (nonatomic, assign) BOOL isType;
@property (nonatomic, assign) BOOL showOne;
@property (nonatomic, assign) BOOL showTwo;

@property (nonatomic, strong) CALayer *orderTypeLayer;
@property (nonatomic, strong) CALayer *orderTimeLayer;
@property (nonatomic, assign) CGFloat YSpace;

// 订单类型
@property (nonatomic, strong) UIImageView *orderTyImg;
@property (nonatomic, strong) UILabel *orderTyLabel;
// 拍下时间
@property (nonatomic, strong) UIImageView *setOrderImg;
@property (nonatomic, strong) UILabel *setOrderLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = WMShopBg;
    self.navigationItem.title = @"订单";
    self.navigationController.navigationBar.barTintColor = WMBlueColor;
    
    self.YSpace = 64 + 48 * KScreenWScale;
    
    self.typeIndex = 0;
    self.timeIndex = 3;

   

    // 菜单数组
    self.orderTypeArray = @[@"全部",@"未发货",@"已发货",@"已收货",@"申请售后中",@"已完成"];
    self.orderTimeArray = @[@"昨天",@"今天",@"最近7天",@"最近30天"];
    
    [self createOrderTabView];
    [self buildSubScreenMenu];
    
}

#pragma mark --- 创建 orderTabView ---
- (void)createOrderTabView
{
    self.orderTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.orderTabView.backgroundColor = WMShopBg;
    self.orderTabView.delegate = self;
    self.orderTabView.dataSource = self;
    self.orderTabView.rowHeight = 40 + 74 * KScreenWScale;
    [self.orderTabView registerClass:[WMOLStyleTableViewCell class] forCellReuseIdentifier:@"orderCell"];
    [self.view addSubview:_orderTabView];
}

#pragma mark --- 创建二级菜单 ---
- (void)buildSubScreenMenu
{
    self.YSpace = 64 + 48 * KScreenWScale;
    
    // 因为 圆角和 阴影 不可两全 所以使用 layer给阴影
    
    // 先绘制Typelayer
    self.orderTypeLayer = [CALayer layer];
    self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 3, 0);
    self.orderTypeLayer.backgroundColor = WMSearchBarBg.CGColor;
    self.orderTypeLayer.shadowColor = WMLineColor.CGColor;
    self.orderTypeLayer.shadowOffset = CGSizeMake(1, 1);
    self.orderTypeLayer.shadowOpacity = 1;
    self.orderTypeLayer.shadowRadius = 6;
    self.orderTypeLayer.cornerRadius = 6;
    
    
    self.orderTypeTabView = [[UITableView alloc]initWithFrame:CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 3, 0) style:UITableViewStylePlain];
    self.orderTypeTabView.backgroundColor = [UIColor whiteColor];
    self.orderTypeTabView.layer.cornerRadius = 6;
    self.orderTypeTabView.clipsToBounds = YES;
    self.orderTypeTabView.delegate = self;
    self.orderTypeTabView.dataSource = self;
    self.orderTypeTabView.rowHeight = 30.5;
    self.orderTypeTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderTypeTabView registerClass:[WMScreenTableViewCell class] forCellReuseIdentifier:@"subScreen"];
    
    // 先绘制Timelayer
    self.orderTimeLayer = [CALayer layer];
    self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
    self.orderTimeLayer.backgroundColor = WMSearchBarBg.CGColor;
    self.orderTimeLayer.shadowColor = WMLineColor.CGColor;
    self.orderTimeLayer.shadowOffset = CGSizeMake(1, 1);
    self.orderTimeLayer.shadowOpacity = 1;
    self.orderTimeLayer.shadowRadius = 6;
    self.orderTimeLayer.cornerRadius = 6;
    
    
    self.orderTimeTabView = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0) style:UITableViewStylePlain];
    self.orderTimeTabView.backgroundColor = [UIColor whiteColor];
    self.orderTimeTabView.layer.cornerRadius = 6;
    self.orderTimeTabView.clipsToBounds = YES;
    self.orderTimeTabView.delegate = self;
    self.orderTimeTabView.dataSource = self;
    self.orderTimeTabView.rowHeight = 30.5;
    self.orderTimeTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderTimeTabView registerClass:[WMScreenTableViewCell class] forCellReuseIdentifier:@"subScreen"];
}

#pragma mark --- 创建表头 ---
- (UIView *)createOrderFormTabViewSectionHeaderView
{
    UIView *tabHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 48 * KScreenWScale)];
    tabHeaderView.backgroundColor = WMShopBg;
    
    // 订单类型
    UIView *orderTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2 - 0.5, 48 * KScreenWScale - 1)];
    orderTypeView.tag = 200;
    orderTypeView.backgroundColor = [UIColor whiteColor];
    [tabHeaderView addSubview:orderTypeView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterSubScreen:)];
    [orderTypeView addGestureRecognizer:tap1];
    
    self.orderTyImg = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 50 * KScreenWScale, 24 * KScreenWScale - 14 + 9, 16, 12)];
    self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
    [orderTypeView addSubview:_orderTyImg];
    
    self.orderTyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 24 * KScreenWScale - 14 + 6, KScreenWidth/2 - 62* KScreenWScale, 18)];
    self.orderTyLabel.font = WMMediumFont(12);
    self.orderTyLabel.textColor = WMHPDark;
    self.orderTyLabel.textAlignment = NSTextAlignmentCenter;
    self.orderTyLabel.text = [NSString stringWithFormat:@"订单类型: %@",  self.orderTypeArray[_typeIndex]];
    [orderTypeView addSubview:_orderTyLabel];
    
    // 拍下时间
    UIView *setOrderView = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth/2 + 0.5, 0, KScreenWidth/2 - 0.5, 48 * KScreenWScale - 1)];
    setOrderView.tag = 300;
    setOrderView.backgroundColor = [UIColor whiteColor];
    [tabHeaderView addSubview:setOrderView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterSubScreen:)];
    [setOrderView addGestureRecognizer:tap2];
    
    self.setOrderImg = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/2 - 41 * KScreenWScale, 24 * KScreenWScale - 14+ 9, 16, 12)];
    self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
    [setOrderView addSubview:_setOrderImg];
    
    self.setOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 24 * KScreenWScale - 14 + 6, KScreenWidth/2 - 53* KScreenWScale, 18)];
    self.setOrderLabel.font = WMMediumFont(12);
    self.setOrderLabel.textColor = WMHPDark;
    self.setOrderLabel.text = [NSString stringWithFormat:@"拍下时间: %@", self.orderTimeArray[_timeIndex]];
    self.setOrderLabel.textAlignment = NSTextAlignmentCenter;
    
    [setOrderView addSubview:_setOrderLabel];
    return tabHeaderView;}


#pragma mark --- 显示二级菜单 ---
- (void)enterSubScreen:(UITapGestureRecognizer *)tap
{
    UIView *tapView = tap.view;
    self.YSpace = 64 + 48 * KScreenWScale;
    
    // 先加 Type渲染
    [self.view.layer addSublayer:_orderTypeLayer];
    // 先加 Time渲染
    [self.view.layer addSublayer:_orderTimeLayer];
    // 加到最前面
    [self.view bringSubviewToFront:self.orderTypeTabView];
    [self.view bringSubviewToFront:self.orderTimeTabView];
    
    if (tapView.tag == 200) {
        if (self.showOne) {
            [self.view addSubview:_orderTimeTabView];
            self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
            self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTypeTabView.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
        }
        else{
            [self.view addSubview:_orderTypeTabView];
            self.orderTyImg.image = [UIImage imageNamed:@"wemart_push"];
            self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
            [UIView animateWithDuration:0.3 animations:^{
                
                self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
                
                self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 182.5);
                self.orderTypeTabView.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 182.5);
                
            } completion:^(BOOL finished) {
                [self.orderTimeTabView removeFromSuperview];
            }];
        }
        self.isType = YES;
        self.showOne = !self.showOne;
        self.showTwo = NO;
    }
    if (tapView.tag == 300) {
        if (self.showTwo) {
            [self.view addSubview:_orderTypeTabView];
            self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
            self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTimeTabView removeFromSuperview];
            }];
        }
        else{
            [self.view addSubview:_orderTimeTabView];
            self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
            self.setOrderImg.image = [UIImage imageNamed:@"wemart_push"];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTypeTabView.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0) ;
                
                self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 121.5);
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 121.5);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
        }
        self.isType = NO;
        self.showOne = NO;
        self.showTwo = !self.showTwo;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self takeBack];
}
#pragma mark --- 收回 ---
- (void)takeBack
{
    self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
    self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
    [UIView animateWithDuration:0.3 animations:^{
        self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
        self.orderTypeTabView.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
        self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
        self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
    } completion:^(BOOL finished) {
        [self.orderTimeTabView removeFromSuperview];
        [self.orderTypeTabView removeFromSuperview];
    }];
}

#pragma mark --- orderFormTabView 代理方法 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.orderTabView]) {
        return 10;
    }
    else{
        if ([tableView isEqual:self.orderTypeTabView]){
            return _orderTypeArray.count;
        }
        else{
            return _orderTimeArray.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.orderTabView]) {
        WMOLStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCell" forIndexPath:indexPath];
        [cell configureOrderFormCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        if ([tableView isEqual:self.orderTypeTabView]){
            WMScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subScreen" forIndexPath:indexPath];
            // 订单类型 开始默认选中的菜单项
            if (indexPath.row == self.typeIndex) {
                [cell configreSubScreenCell:_orderTypeArray[indexPath.row] isSelected:YES];
            }
            else{
                [cell configreSubScreenCell:_orderTypeArray[indexPath.row] isSelected:NO];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else {
            WMScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subScreen" forIndexPath:indexPath];
            // 拍下时间 开始默认选中的菜单项
            if (indexPath.row == self.timeIndex) {
                [cell configreSubScreenCell:_orderTimeArray[indexPath.row] isSelected:YES];
            }
            else{
                [cell configreSubScreenCell:_orderTimeArray[indexPath.row] isSelected:NO];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeadView = [[UIView alloc]init];
    if ([tableView isEqual:self.orderTabView]) {
        sectionHeadView = [self createOrderFormTabViewSectionHeaderView];
    }
    return sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.orderTabView]) {
        return 48 * KScreenWScale;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.orderTabView]) {
        // 跳转订单详情
       
    }
    else{
        // 收起下拉筛选菜单
        // 收起下拉筛选菜单
        if (self.isType) {
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeLayer.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTypeTabView.frame = CGRectMake(6.5, self.YSpace, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
            // 记录被选中的菜单下表 刷新菜单
            self.typeIndex = indexPath.row;
            self.orderTyLabel.text = [NSString stringWithFormat:@"订单类型: %@", self.orderTypeArray[indexPath.row]];
            self.orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
            [self.orderTypeTabView reloadData];
        }
        else{
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTimeLayer.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, self.YSpace, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTimeTabView removeFromSuperview];
            }];
            // 记录被选中的菜单下表 刷新菜单
            self.timeIndex = indexPath.row;
            self.setOrderLabel.text = [NSString stringWithFormat:@"拍下时间: %@", self.orderTimeArray[indexPath.row]];
            self.setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
            [self.orderTimeTabView reloadData];
        }
        self.showOne = NO;
        self.showTwo = NO;
    }
}

#pragma mark --- scrollView ---
// 下拉菜单展开时 滚动tableView 收起下拉菜单
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.orderTabView]) {
        [self takeBack];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
