//
//  Nav.m
//  CustomPopAnimation
//
//  Created by Jazys on 15/3/30.
//  Copyright (c) 2015年 Jazys. All rights reserved.
//

#import "CustomTransitionNavigation.h"
#import "NavigationInteractiveTransition.h"

@interface CustomTransitionNavigation () <UIGestureRecognizerDelegate>
@end

@implementation CustomTransitionNavigation

- (void)viewDidLoad {
    [super viewDidLoad];

    // 禁用原来的手势
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    // 创建新的手势
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    // 为新手势设置响应
    NavigationInteractiveTransition *navT = [[NavigationInteractiveTransition alloc] initWithViewController:self];
    [popRecognizer addTarget:navT action:@selector(handleControllerPop:)];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
