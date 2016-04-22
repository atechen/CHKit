//
//  FullScreenBackController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/21.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "FullScreenBackController.h"
#import "NextViewController.h"

@interface FullScreenBackController ()

@end

@implementation FullScreenBackController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"PUSH" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@(30));
        make.width.equalTo(@(100));
    }];
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) pushClick
{
    NextViewController *viewController = [[NextViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
