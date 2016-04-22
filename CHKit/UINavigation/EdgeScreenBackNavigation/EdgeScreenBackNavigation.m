//
//  EdgeScreenBackNavigation.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/21.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "EdgeScreenBackNavigation.h"

@interface EdgeScreenBackNavigation ()<UIGestureRecognizerDelegate>

@end

@implementation EdgeScreenBackNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

//#pragma mark - 防止Push过程中触发手势，产生问题
//// 禁用手势
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//}
//// 打开手势
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
//}

@end
