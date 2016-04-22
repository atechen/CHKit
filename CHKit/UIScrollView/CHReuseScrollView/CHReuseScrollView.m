//
//  CHReuseScrollView.m
//  CHKit
//
//  Created by 陈 斐 on 16/4/18.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "CHReuseScrollView.h"
#import "CHReuseScrollViewCell.h"
#import "objc/runtime.h"

static NSString *const CHReuseScrollViewCellIndexKey = @"CHReuseScrollViewCellIndexKey";

@interface CHReuseScrollView ()
{
    NSCache *_reuseViewCache;
    NSMutableArray *_subviewOnArr;
    
    CGFloat _cellWidth;
    CGFloat _cellHeight;
    NSInteger _cellCount;
    CGFloat _standardDistance;
}
@end

@implementation CHReuseScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _reuseViewCache = [[NSCache alloc] init];
        _subviewOnArr = [NSMutableArray array];
    }
    return self;
}

- (void) setCellWidth:(CGFloat)width cellHeight:(CGFloat)height
{
    _cellWidth = width;
    _cellHeight = height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - 初始化时布局子试图
- (void) initHoriLayOutSubViews
{
    CGSize selfSize = self.frame.size;
    _cellCount = [_reuseDelegate cellNumberInScrollView:self];
    
    if (_cellCount * _cellWidth <= selfSize.width) {// 内容没有占满
        self.contentSize = selfSize;
    }
    else {
        //1. 扩大contentsize，方便无限滚动
        self.contentSize = CGSizeMake(selfSize.width + 3*_cellWidth, selfSize.height);
        _standardDistance = self.contentSize.width - selfSize.width;
        //2. 创建cell：可见区域的cell个数 + 2
        //2.1 头上增加一个Cell，用于循环滚动
        CHReuseScrollViewCell *headerCell = [self cellInIndex:_cellCount-1];
        headerCell.frame = CGRectMake(_standardDistance-_cellWidth, 0, _cellWidth, _cellHeight);
        [self addSubview:headerCell];
        [_subviewOnArr addObject:headerCell];
        //2.2 为可见区域，addSubview
        for (int i = 0; i*_cellWidth < selfSize.width + _cellWidth; i++) {
            CHReuseScrollViewCell *cell = [self cellInIndex:i];
            cell.frame = CGRectMake(_standardDistance + i*_cellWidth, 0, _cellWidth, _cellHeight);
            [self addSubview:cell];
            [_subviewOnArr addObject:cell];
        }
        [self setContentOffset:CGPointMake(_standardDistance, 0)];
    }
}

#pragma mark - 滚动时布局子试图
- (void) scrollHoriLayOutSubViews
{
    CGPoint contentOffset = self.contentOffset;
    if (contentOffset.y-_standardDistance>_cellWidth || contentOffset.y-_standardDistance<-_cellWidth) {
        if (contentOffset.y-_standardDistance > _cellWidth) {// 当前面第二个cell离开屏幕时
            // 添加一个cell到最后
            NSIndexPath *lastCellIndexPath = objc_getAssociatedObject([_subviewOnArr lastObject], &CHReuseScrollViewCellIndexKey);
            CHReuseScrollViewCell *newCell = [self cellInIndex:lastCellIndexPath.row + 1];
            [_subviewOnArr addObject:newCell];
            [self addSubview:newCell];
            // 最前面的cell移除
            CHReuseScrollViewCell *headCell = _subviewOnArr[0];
            [_subviewOnArr removeObject:headCell];
            [headCell removeFromSuperview];
        }
    }
}

#pragma mark 
// 根据索引号返回cell
- (CHReuseScrollViewCell *) cellInIndex:(NSInteger)index
{
    // 获取真正的索引号
    index += _cellCount;
    NSInteger realIndex = index % _cellCount;
    
    CHReuseScrollViewCell *cell = [_reuseDelegate scrollView:self cellForRowAtIndex:realIndex];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:realIndex inSection:0];
    objc_setAssociatedObject(cell, &CHReuseScrollViewCellIndexKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return cell;
}




// 首次显示时在最前面多显示一个视图(视图与最后一个相同) 始终往下拉,所以最上面的边重叠或者最下面的边在区域内部
-(void) initLayOutSubViews1
{
    // 调整滚动区域
    CGFloat minHeight = self.frame.size.height + _itemHeight*3;
    if (self.contentSize.height/self.frame.size.height <lestHeight)
        self.contentSize = CGSizeMake(self.contentSize.width,lestHeight) ;
    
    // 所有内容视图总高 小于 scrollview的高
    if (_itemCount*_itemHeight < self.frame.size.height)
        tooShortContent = YES;
    
    // 把显示的内容放在中间，同时scrollview滚动到内容视图的第一个
    scrollDistance = (self.contentSize.height - self.frame.size.height )/2;
    if (tooShortContent)
        scrollDistance = (self.contentSize.height - (numberOfSubViews*viewHeight) )/2;
    
    CGFloat* dis = (CGFloat*)malloc(sizeof(CGFloat));
    int firstIndex = [self positionOfSelect:dis];
    self.contentOffset = CGPointMake(0, scrollDistance + *dis);
    free(dis);
    
    // 创建一个headView。如果内容视图能填充满scrollview，则将headView放到内容视图的前面
    ISView* headView = [self viewForIndex:firstIndex-1];
    headView.frame = CGRectMake(0, scrollDistance-viewHeight, viewWidth, viewHeight);
    if (!tooShortContent) {
        [self.viewArray addObject:headView];
        [self addSubview:headView];
        selectIndex++;
    }
    
    // 创建可见范围内的所有内容子试图，并添加到scrollview
    CGFloat scrollLimite = tooShortContent?numberOfSubViews*viewHeight:self.frame.size.height + viewHeight;
    CGFloat scrollUnit = viewHeight;
    for (int i = firstIndex; (i-firstIndex)*scrollUnit< scrollLimite; i++) {
        ISView* view = [self viewForIndex:i];
        CGRect r = view.frame;
        r = CGRectMake(0, scrollDistance+(i-firstIndex)*scrollUnit, viewWidth, viewHeight);
        view.frame = r;
        [self.viewArray addObject:view];
        [self addSubview:view];
    }
    [self selectIndex:selectIndex];
}

- (void) scrollLayOutSubViews
{
    CGPoint currentOffset = [self contentOffset];
    CGFloat distanceY = 0;
    if ((currentOffset.y-scrollDistance) > viewHeight || (currentOffset.y-scrollDistance) < -viewHeight) {
        if (currentOffset.y-scrollDistance > viewHeight) {
            distanceY = currentOffset.y - viewHeight;
            ISView* oldView = [self.viewArray objectAtIndex:0];
            NSMutableArray * array = [viewDictionary objectForKey:oldView.indentifier];
            if (array != nil)
                [array addObject:oldView];
            [oldView removeFromSuperview];
            [self.viewArray removeObjectAtIndex:0];
            int lastIndex = [[(ISView*)[viewArray lastObject] indexPath] row];
            ISView* newView = [self viewForIndex:lastIndex+1];
            [self addSubview:newView];
            [self.viewArray addObject:newView];
        }
        else if (currentOffset.y-scrollDistance < -viewHeight) {
            distanceY = viewHeight + currentOffset.y;
            ISView* oldView = [self.viewArray lastObject];
            NSMutableArray * array = [viewDictionary objectForKey:oldView.indentifier];
            if (array != nil)
                [array addObject:oldView];
            [oldView removeFromSuperview];
            [self.viewArray removeObjectAtIndex:[viewArray count]-1];
            int headIndex = [[(ISView*)[viewArray objectAtIndex:0] indexPath] row];
            ISView* newView = [self viewForIndex:headIndex-1+numberOfSubViews];
            [self addSubview:newView];
            [self.viewArray insertObject:newView atIndex:0];
        }
        CGFloat h = -viewHeight;
        for (ISView* view in viewArray) {
            view.frame = CGRectMake(0, scrollDistance+h, viewWidth,viewHeight);
            h += viewHeight;
        }
        [self setContentOffset:CGPointMake(0,  distanceY)];
    }

}

@end
