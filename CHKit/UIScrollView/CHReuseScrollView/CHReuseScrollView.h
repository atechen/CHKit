//
//  CHReuseScrollView.h
//  CHKit
//
//  Created by 陈 斐 on 16/4/18.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CHReuseScrollViewScrollHorizontal,
    CHReuseScrollViewScrollVertical
}CHReuseScrollViewScrollDirection;

@class CHReuseScrollViewCell;
@protocol CHReuseScrollViewDelegate;

@interface CHReuseScrollView : UIScrollView
@property (nonatomic, weak) id<CHReuseScrollViewDelegate> reuseDelegate;
@property (nonatomic, assign) CHReuseScrollViewScrollDirection scrollDirection;
@end

@protocol CHReuseScrollViewDelegate <NSObject>

- (NSInteger)cellNumberInScrollView:(CHReuseScrollView *)scrollView;
- (CHReuseScrollViewCell *)scrollView:(CHReuseScrollView *)scrollView cellForRowAtIndex:(NSInteger)index;

@end
