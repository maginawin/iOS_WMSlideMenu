//
//  WMMenuTableViewController.h
//  WMSlideMenu
//
//  Created by maginawin on 15-3-6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WMMenuTableViewControllerDelegate <NSObject>

@required

- (void)menuTableViewController:(UITableView *)tableView  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WMMenuTableViewController : UITableViewController

@property (nonatomic, strong) id<WMMenuTableViewControllerDelegate> delegate;

@end
