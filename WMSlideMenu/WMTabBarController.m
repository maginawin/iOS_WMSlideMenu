//
//  WMTabBarController.m
//  WMSlideMenu
//
//  Created by maginawin on 15-3-6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMTabBarController.h"

@interface WMTabBarController ()

@property (nonatomic, strong) WMMenuTableViewController* mVC;

@end

@implementation WMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasicViews];
    [self setupSwipeGesture];
}

#pragma mark - setup views

- (void)setupBasicViews {
    [self.tabBar setHidden:YES];
    _mVC = [self.storyboard instantiateViewControllerWithIdentifier:@"idMenuVC"];
//    _mVC.delegate = self;
//    [self.view.window addSubview:_mVC.view];
//    [self.view insertSubview:_mVC.view belowSubview:self.tabBarController.selectedViewController.view];
//    [self.view insertSubview:_mVC.view atIndex:1];
//    [self.view addSubview:_mVC.view];
//    [self.view bringSubviewToFront:self.tabBarController.selectedViewController.view];
}

- (void)setupSwipeGesture {
    for (int i = 0; i < 2; i++) {
        UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] init];
        swipeGesture.numberOfTouchesRequired = 1;
        swipeGesture.direction = 1 << i;
        [swipeGesture addTarget:self action:@selector(handleSwipeGesture:)];
        [self.view addGestureRecognizer:swipeGesture];
    }
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer*)swipeGesture {
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"右");
        self.selectedViewController.view.frame = CGRectMake(self.view.bounds.size.width / 2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"左");
        self.selectedViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
}

#pragma mark - Menu table view delegate

- (void)menuTableViewController:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = indexPath.row;
    NSArray* views = [self viewControllers];
    if (row <= views.count) {
        self.selectedIndex = row - 1;
    }
    self.selectedViewController.view.frame = CGRectMake(160, 240, 320, 480);
}

@end
