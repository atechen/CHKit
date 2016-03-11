//
//  MutiItemTabelViewCell.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/10.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "MutiItemTabelViewCell.h"
#import "ItemCollectionViewCell.h"

@interface MutiItemTabelViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSArray *_itemInfoArr;
    
    UICollectionView *_collectionView;
    NSInteger _itemCount;
}

@end

@implementation MutiItemTabelViewCell

static NSString *itemCollectionViewCellID = @"itemCollectionViewCellID";
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        // 创建UICollectionView，不要使用AutoLayout布局，防止与UICollectionView初始化方法中的frame冲突
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);
        layout.minimumInteritemSpacing = 5;
        layout.minimumLineSpacing = 3;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _collectionView.backgroundColor = [UIColor blueColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:itemCollectionViewCellID];
        
    }
    return self;
}

#pragma mark - 为UICollectionView添加元素，更新UICollectionView的高度， 并返回TableViewCell的高度
- (CGFloat) setItemInfoArr:(NSArray *)itemArr
{
    _itemInfoArr = itemArr;
    _itemCount = itemArr.count;
    
    // 添加元素
    [_collectionView reloadData];
    
    // 更新UICollectionView的高度
    CGRect collectViewFrame = _collectionView.frame;
    collectViewFrame.size = _collectionView.collectionViewLayout.collectionViewContentSize;
    _collectionView.frame = collectViewFrame;
    
    // 返回TableViewCell的高度
    return _collectionView.collectionViewLayout.collectionViewContentSize.height;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:itemCollectionViewCellID forIndexPath:indexPath];
    collectionCell.itemValue = _itemInfoArr[indexPath.row];
    return collectionCell;
}

@end
