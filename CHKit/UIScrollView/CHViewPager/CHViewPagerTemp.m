//
//  CHViewPagerTemp.m
//  CHKit
//
//  Created by 陈 斐 on 16/4/18.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "CHViewPagerTemp.h"

@interface CHViewPagerTemp ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation CHViewPagerTemp

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        self.imageNameArr = @[@"1", @"2", @"3"];
        [self realizeScrollLoop1];
    }
    return self;
}

/**
 *   第一种方式：利用结束的位置来重新设置ScrollView ContentOffset的值，让人产生视觉上的无限循环
 *   优点：代码易懂
 *   缺点，会创建多余的内存。
 */
- (void)realizeScrollLoop1
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = NO;
    scrollView.pagingEnabled = YES;
    scrollView.frame = self.bounds ;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView setContentSize:CGSizeMake((self.imageNameArr.count + 2) * scrollView.frame.size.width, 0)];
    
    CGSize scrollViewSize = scrollView.frame.size;
    
    // 遍历创建子控件，放到索引号为 1 到 imageNameArr.count 的位置上
    [self.imageNameArr enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake((idx+1) * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        [scrollView addSubview:imageView];
    }];
    
    // 将最后一张图片赋值一份，放到索引为0的位置
    UIImageView *lastImageViewOnHead = [[UIImageView alloc] init];
    lastImageViewOnHead.image = [UIImage imageNamed:self.imageNameArr[self.imageNameArr.count - 1]];
    lastImageViewOnHead.frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height);
    [scrollView addSubview:lastImageViewOnHead];
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
//    view2.backgroundColor = [UIColor blueColor];
//    [lastImageViewOnHead addSubview:view2];
    
    // 将第一张图片赋值一份，放到索引为imageNameArr.count + 1的位置
    UIImageView *firstImageViewOnFoot = [[UIImageView alloc] init];
    firstImageViewOnFoot.image = [UIImage imageNamed:self.imageNameArr[0]];
    firstImageViewOnFoot.frame = CGRectMake(scrollViewSize.width * (self.imageNameArr.count + 1), 0, scrollViewSize.width, scrollViewSize.height);
    [scrollView addSubview:firstImageViewOnFoot];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
//    view.backgroundColor = [UIColor redColor];
//    [firstImageViewOnFoot addSubview:view];
    
    [scrollView setContentOffset:CGPointMake(scrollViewSize.width, 0)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 减速完成后，滚动到索引号
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    //如果是第0页，马上跳转到 倒数第二页
    if (page == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (self.imageNameArr.count), 0)];
    }
    else if (page == self.imageNameArr.count + 1){// 如果是最后一页，马上跳转到第1页
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
    }
}

@end
