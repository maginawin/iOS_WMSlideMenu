//
//  WMTabBarController.h
//  WMSlideMenu
//
//  Created by maginawin on 15-3-6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WMTabBarControllerDelegate <NSObject>

@required

- (void)tabBarController:(UIView*)tabBarControllerView swipeGestureRecognizerDirection:(UISwipeGestureRecognizer*)swipeDirection;

@end

@interface WMTabBarController : UITabBarController

@property (nonatomic, weak) id<WMTabBarControllerDelegate> wmTabBarDelegate;

@end
