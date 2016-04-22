//
//  CHNavigationController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/21.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "FullScreenBackNavigation.h"

@interface FullScreenBackNavigation ()<UIGestureRecognizerDelegate>

@end

@implementation FullScreenBackNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 全屏返回手势的target：
    // 方案一：interactivePopGestureRecognizer手势的代理
    id backGestureTarget = self.interactivePopGestureRecognizer.delegate;
    /* // 方案二：通过_targets属性
    NSMutableArray *_targets = [self.interactivePopGestureRecognizer valueForKey:@"_targets"];
    // 获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    id gestureRecognizerTarget = [_targets firstObject];
    // 获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    id backGestureTarget = [gestureRecognizerTarget valueForKey:@"_target"];
    */
    //2. 响应方法
    SEL selector = NSSelectorFromString(@"handleNavigationTransition:");
    
    //3. 重新创建手势
    UIPanGestureRecognizer *backGesture = [[UIPanGestureRecognizer alloc] initWithTarget:backGestureTarget action:selector];
    backGesture.delegate = self;
    [self.interactivePopGestureRecognizer.view addGestureRecognizer:backGesture];
    
    //4. 禁用系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
