//
//  WMTabBarController.m
//  WMSlideMenu
//
//  Created by maginawin on 15-3-6.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMTabBarController.h"

@interface WMTabBarController ()

@property (nonatomic) CGPoint beganPoint;

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
    _beganPoint = CGPointZero;
    
}

- (void)setupSelfViewFrameSizeXOffset:(CGFloat)xOffset {
    [UIView animateWithDuration:0.2 animations:^ {
        self.view.frame = CGRectMake(xOffset, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

#pragma mark - Gesture recognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    _beganPoint = [touch locationInView:self.view];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint nowPoint = [touch locationInView:self.view];
    if (self.view.frame.origin.x >= -20) {
        CGFloat xOffset = (nowPoint.x - _beganPoint.x);
        self.view.transform = CGAffineTransformTranslate(self.view.transform, xOffset, 0);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!CGPointEqualToPoint(_beganPoint, CGPointZero)) {
        if (self.view.frame.origin.x > self.view.frame.size.width / 2) {
            [self setupSelfViewFrameSizeXOffset:self.view.frame.size.width / 2];
        } else {
            [self setupSelfViewFrameSizeXOffset:0];
        }
    }
    _beganPoint = CGPointZero;
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
        [self setupSelfViewFrameSizeXOffset:self.view.frame.size.width / 2];
    }
    else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self setupSelfViewFrameSizeXOffset:0];
    }
    _beganPoint = CGPointZero;
}

@end
