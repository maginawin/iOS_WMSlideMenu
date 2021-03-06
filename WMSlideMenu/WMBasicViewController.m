//
//  WMBasicViewController.m
//  WMSlideMenu
//
//  Created by wangwendong on 15/3/6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMBasicViewController.h"

@interface WMBasicViewController ()

@property (strong, nonatomic) WMMenuTableViewController* menuVC;
@property (strong, nonatomic) WMTabBarController* tabBarC;

@end

@implementation WMBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicViews];
}

#pragma mark - Setup views

- (void)setupBasicViews {
    _menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idMenuVC"];
    [self addChildViewController:_menuVC];
    [self.view addSubview:_menuVC.view];
    _menuVC.view.frame = self.view.frame;
    _menuVC.delegate = self;
    
    _tabBarC = [self.storyboard instantiateViewControllerWithIdentifier:@"idTabBarController"];
    [self addChildViewController:_tabBarC];
    [self.view addSubview:_tabBarC.view];
    _tabBarC.view.frame = self.view.frame;
}

#pragma mark - Menu delegate

- (void)menuTableViewController:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    _tabBarC.selectedIndex = row - 1;
    [_tabBarC setupSelfViewFrameSizeXOffset:0];
}

@end
