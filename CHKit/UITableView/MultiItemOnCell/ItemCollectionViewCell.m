//
//  ItemCollectionViewCell.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/10.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "ItemCollectionViewCell.h"

@interface ItemCollectionViewCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
@end

@implementation ItemCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:25];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.alpha = 0.5;
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}
- (void)setItemValue:(id)itemValue
{
    _itemValue = itemValue;
    int valueInt = [itemValue intValue];
    NSString *imageName = valueInt%2 == 0?@"atechen.jpg":@"wuyanzu.jpg";
    _imageView.image = [UIImage imageNamed:imageName];
    
    _titleLabel.text = [NSString stringWithFormat:@"%@", _itemValue];
}
@end