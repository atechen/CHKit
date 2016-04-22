//
//  ViewPageScrollController.m
//  CHKit
//
//  Created by 陈 斐 on 16/4/18.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "ViewPageScrollController.h"
#import "CHViewPager.h"

#import "CHViewPagerTemp.h"


@interface ViewPageScrollController ()

@end

@implementation ViewPageScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    CHViewPagerTemp *viewPager = [[CHViewPagerTemp alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
//    viewPager.imageNameArr = @[@"1", @"2", @"3"];
    viewPager.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:viewPager];
    
}

@end
