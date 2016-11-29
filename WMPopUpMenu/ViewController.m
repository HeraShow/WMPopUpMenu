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
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = WMShopBg;
    self.navigationItem.title = @"订单";
    self.navigationController.navigationBar.barTintColor = WMBlueColor;

    [self createOrderTabView];
    [self buildSubScreenMenu];

    // 菜单数组
    self.orderTypeArray = @[@"全部",@"未发货",@"已发货",@"已收货",@"申请售后中",@"已完成"];
    self.orderTimeArray = @[@"昨天",@"今天",@"最近7天",@"最近30天"];
    
}

#pragma mark --- 创建 orderTabView ---
- (void)createOrderTabView
{
    self.orderTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.orderTabView.backgroundColor = WMShopBg;
    self.orderTabView.delegate = self;
    self.orderTabView.dataSource = self;
    self.orderTabView.tableHeaderView = [self createOrderTabViewTabHeaderView];
    self.orderTabView.rowHeight = 40 + 74 * KScreenWScale;
    [self.orderTabView registerClass:[WMOLStyleTableViewCell class] forCellReuseIdentifier:@"orderCell"];
    [self.view addSubview:_orderTabView];
}

#pragma mark --- 创建二级菜单 ---
- (void)buildSubScreenMenu
{
    self.orderTypeTabView = [[UITableView alloc]initWithFrame:CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0) style:UITableViewStylePlain];
    self.orderTypeTabView.backgroundColor = WMSearchBarBg;
    self.orderTypeTabView.layer.borderWidth = 0.5f;
    self.orderTypeTabView.layer.borderColor = WMLineColor.CGColor;
    self.orderTypeTabView.layer.cornerRadius = 4 * KScreenWScale;
    self.orderTypeTabView.delegate = self;
    self.orderTypeTabView.dataSource = self;
    self.orderTypeTabView.rowHeight = 30;
    self.orderTypeTabView.scrollEnabled = NO;
    self.orderTypeTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderTypeTabView registerClass:[WMScreenTableViewCell class] forCellReuseIdentifier:@"subScreen"];
    
    self.orderTimeTabView = [[UITableView alloc]initWithFrame:CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0) style:UITableViewStylePlain];
    self.orderTimeTabView.backgroundColor = WMSearchBarBg;
    self.orderTimeTabView.layer.borderWidth = 0.5f;
    self.orderTimeTabView.layer.borderColor = WMLineColor.CGColor;
    self.orderTimeTabView.layer.cornerRadius = 4 * KScreenWScale;
    self.orderTimeTabView.delegate = self;
    self.orderTimeTabView.dataSource = self;
    self.orderTimeTabView.rowHeight = 30;
    self.orderTypeTabView.scrollEnabled = NO;
    self.orderTimeTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.orderTimeTabView registerClass:[WMScreenTableViewCell class] forCellReuseIdentifier:@"subScreen"];
}

#pragma mark --- 创建表头 ---
- (UIView *)createOrderTabViewTabHeaderView
{
    UIView *tabHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 31)];
    tabHeaderView.backgroundColor = WMShopBg;
    
    // 订单类型
    UIView *orderTypeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2 - 0.5, 30)];
    orderTypeView.tag = 200;
    orderTypeView.backgroundColor = [UIColor whiteColor];
    [tabHeaderView addSubview:orderTypeView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterSubScreen:)];
    [orderTypeView addGestureRecognizer:tap1];
    
    UIImageView *orderTyImg = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/4 + 21, 9, 16, 12)];
    orderTyImg.image = [UIImage imageNamed:@"wemart_pull"];
    [orderTypeView addSubview:orderTyImg];
    
    UILabel *orderTyLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/4 - 38, 6, 50, 18)];
    orderTyLabel.font = WMLightFont(12);
    orderTyLabel.textColor = WMHPDark;
    orderTyLabel.text = @"订单类型";
    orderTyLabel.textAlignment = NSTextAlignmentCenter;
    [orderTypeView addSubview:orderTyLabel];
    
    // 拍下时间
    UIView *setOrderView = [[UIView alloc]initWithFrame:CGRectMake(KScreenWidth/2 + 0.5, 0, KScreenWidth/2 - 0.5, 30)];
    setOrderView.tag = 300;
    setOrderView.backgroundColor = [UIColor whiteColor];
    [tabHeaderView addSubview:setOrderView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enterSubScreen:)];
    [setOrderView addGestureRecognizer:tap2];
    
    UIImageView *setOrderImg = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth/4 + 21, 9, 16, 12)];
    setOrderImg.image = [UIImage imageNamed:@"wemart_pull"];
    [setOrderView addSubview:setOrderImg];
    
    UILabel *setOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth/4 - 38, 6, 50, 18)];
    setOrderLabel.font = WMLightFont(12);
    setOrderLabel.textColor = WMHPDark;
    setOrderLabel.textAlignment = NSTextAlignmentCenter;
    setOrderLabel.text = @"拍下时间";
    [setOrderView addSubview:setOrderLabel];
    return tabHeaderView;
}


#pragma mark --- 显示二级菜单 ---
- (void)enterSubScreen:(UITapGestureRecognizer *)tap
{
    UIView *tapView = tap.view;
    if (tapView.tag == 200) {
        if (self.showOne) {
            [self.orderTabView addSubview:_orderTimeTabView];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0) ;
                //                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 120);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
        }
        else{
            [self.orderTabView addSubview:_orderTypeTabView];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0);
                self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 180);
                
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
            [self.orderTabView addSubview:_orderTypeTabView];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTimeTabView removeFromSuperview];
            }];
        }
        else{
            [self.orderTabView addSubview:_orderTimeTabView];
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0) ;
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 120);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
        }
        self.isType = NO;
        self.showOne = NO;
        self.showTwo = !self.showTwo;
    }
}

#pragma mark --- 收回 ---
- (void)takeBack
{
    [UIView animateWithDuration:0.3 animations:^{
        self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0) ;
        self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0);
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
            if (self.typeIndex == 0 && indexPath.row == 0) {
                [cell configreSubScreenCell:_orderTypeArray[indexPath.row] isSelected:YES];

            }
            else{
                if (indexPath.row == self.typeIndex - 100) {
                    [cell configreSubScreenCell:_orderTypeArray[indexPath.row] isSelected:YES];
                    
                }
                else{
                    [cell configreSubScreenCell:_orderTypeArray[indexPath.row] isSelected:NO];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            WMScreenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subScreen" forIndexPath:indexPath];
            // 拍下时间 开始默认选中的菜单项
            if (self.timeIndex == 0 && indexPath.row == 3) {
                 [cell configreSubScreenCell:_orderTimeArray[indexPath.row] isSelected:YES];
            }
            else{
                if (indexPath.row == self.timeIndex - 200) {
                    [cell configreSubScreenCell:_orderTimeArray[indexPath.row] isSelected:YES];
                    
                }
                else{
                    [cell configreSubScreenCell:_orderTimeArray[indexPath.row] isSelected:NO];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.orderTabView]) {
        // 跳转订单详情
       
    }
    else{
        // 收起下拉筛选菜单
        if (self.isType) {
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTypeTabView removeFromSuperview];
            }];
            // 记录被选中的菜单下表 刷新菜单
            self.typeIndex = indexPath.row + 100;
            [self.orderTypeTabView reloadData];
        }
        else{
            [UIView animateWithDuration:0.3 animations:^{
                self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0);
            } completion:^(BOOL finished) {
                [self.orderTimeTabView removeFromSuperview];
            }];
            // 记录被选中的菜单下表 刷新菜单
            self.timeIndex = indexPath.row + 200;
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
        [UIView animateWithDuration:0.3 animations:^{
            self.orderTypeTabView.frame = CGRectMake(6.5, 31, KScreenWidth/2 - 14, 0) ;
            self.orderTimeTabView.frame = CGRectMake(KScreenWidth/2 + 7.5, 31, KScreenWidth/2 - 14, 0);
        } completion:^(BOOL finished) {
            [self.orderTimeTabView removeFromSuperview];
            [self.orderTypeTabView removeFromSuperview];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
