//
//  CollectionViewCell.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/9.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Masonry.h"

@implementation CollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.equalTo(@5);
            make.rightMargin.equalTo(@5);
            make.topMargin.equalTo(@5);
            make.bottomMargin.equalTo(@5);
            [make install];
        }];
    }
    return self;
}
@end
