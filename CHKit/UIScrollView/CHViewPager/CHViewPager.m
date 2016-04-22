//
//  CHViewPager.m
//  CHKit
//
//  Created by 陈 斐 on 16/4/14.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "CHViewPager.h"

@interface CHViewPager ()<UIScrollViewDelegate>
@end

@implementation CHViewPager
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = NO;
        self.alwaysBounceHorizontal = NO;
        self.pagingEnabled = YES;
        self.frame = self.bounds ;
        self.delegate = self;
        
        self.imageNameArr = @[@"1", @"2", @"3"];
        [self realizeScrollLoop];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


- (void)realizeScrollLoop
{
    [self setContentSize:CGSizeMake((self.imageNameArr.count + 2) * self.frame.size.width, 0)];
    
    CGSize scrollViewSize = self.frame.size;
    
    // 遍历创建子控件，放到索引号为 1 到 imageNameArr.count 的位置上
    [self.imageNameArr enumerateObjectsUsingBlock:^(NSString *imageName, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        imageView.frame = CGRectMake((idx+1) * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height);
        [self addSubview:imageView];
    }];
    
    // 将最后一张图片赋值一份，放到索引为0的位置
    UIImageView *lastImageViewOnHead = [[UIImageView alloc] init];
    lastImageViewOnHead.image = [UIImage imageNamed:self.imageNameArr[self.imageNameArr.count - 1]];
    lastImageViewOnHead.frame = CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height);
    [self addSubview:lastImageViewOnHead];
    //    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    //    view2.backgroundColor = [UIColor blueColor];
    //    [lastImageViewOnHead addSubview:view2];
    
    // 将第一张图片赋值一份，放到索引为imageNameArr.count + 1的位置
    UIImageView *firstImageViewOnFoot = [[UIImageView alloc] init];
    firstImageViewOnFoot.image = [UIImage imageNamed:self.imageNameArr[0]];
    firstImageViewOnFoot.frame = CGRectMake(scrollViewSize.width * (self.imageNameArr.count + 1), 0, scrollViewSize.width, scrollViewSize.height);
    [self addSubview:firstImageViewOnFoot];
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    //    view.backgroundColor = [UIColor redColor];
    //    [firstImageViewOnFoot addSubview:view];
    
    [self setContentOffset:CGPointMake(scrollViewSize.width, 0)];
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
