//
//  WMTabBarController.m
//  WMSlideMenu
//
//  Created by maginawin on 15-3-6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMTabBarController.h"

typedef NS_ENUM(NSInteger, WMSlideMenuState) {
    WMSlideMenuStateOpen = 0,
    WMSlideMenuStateClosed
};

@interface WMTabBarController ()

@property (nonatomic) CGPoint beganPoint;
@property (nonatomic) WMSlideMenuState slideMenuState;

@end

@implementation WMTabBarController
static float menuInterval;

- (void)viewDidLoad {
    [super viewDidLoad];
    menuInterval = self.view.frame.size.width * 0.618;
    [self setupBasicViews];
    [self addShadow];
//    [self setupSwipeGesture];
}

#pragma mark - setup views

- (void)setupBasicViews {
    [self.tabBar setHidden:YES];
    _beganPoint = CGPointZero;
    _slideMenuState = WMSlideMenuStateClosed;
}

- (void)addShadow {
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = CGSizeZero;
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shadowRadius = 4;
}

- (void)setupSelfViewFrameSizeXOffset:(CGFloat)xOffset {
    [UIView animateWithDuration:0.1 animations:^ {
        self.view.transform = CGAffineTransformMakeTranslation(xOffset, 0);
    }];
}

#pragma mark - Gesture recognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    _beganPoint = [touch locationInView:self.view];
    NSLog(@"%f", _beganPoint.x);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self.view];
    CGFloat xOffset = (nowPoint.x - _beganPoint.x);
    if (xOffset < 0) {
        if (_slideMenuState == WMSlideMenuStateOpen || self.view.frame.origin.x > 0) {
            self.view.transform = CGAffineTransformTranslate(self.view.transform, xOffset, 0);
        }
    } else {
        self.view.transform = CGAffineTransformTranslate(self.view.transform, xOffset, 0);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_slideMenuState == WMSlideMenuStateOpen) {
        [self setupSelfViewFrameSizeXOffset:0];
        _slideMenuState = WMSlideMenuStateClosed;
    } else {
        if (self.view.frame.origin.x > 36) {
            [self setupSelfViewFrameSizeXOffset:menuInterval];
            _slideMenuState = WMSlideMenuStateOpen;
        } else {
            [self setupSelfViewFrameSizeXOffset:0];
        }
    }
    _beganPoint = CGPointZero;
}

//- (void)setupSwipeGesture {
//    for (int i = 0; i < 2; i++) {
//        UISwipeGestureRecognizer* swipeGesture = [[UISwipeGestureRecognizer alloc] init];
//        swipeGesture.numberOfTouchesRequired = 1;
//        swipeGesture.direction = 1 << i;
//        [swipeGesture addTarget:self action:@selector(handleSwipeGesture:)];
//        [self.view addGestureRecognizer:swipeGesture];
//    }
//}
//
//- (void)handleSwipeGesture:(UISwipeGestureRecognizer*)swipeGesture {
//    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
//        [self setupSelfViewFrameSizeXOffset:self.view.frame.size.width / 2];
//    }
//    else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
//        [self setupSelfViewFrameSizeXOffset:0];
//    }
//    _beganPoint = CGPointZero;
//}

@end
