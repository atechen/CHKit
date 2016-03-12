//
//  DynamicTableViewCell.m
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import "DynamicTableViewCell.h"

@interface DynamicTableViewCell ()
{
    UIImageView *_imageView;
    UILabel *_contentLabel;
    UILabel *_titiLabel;
}
@end

@implementation DynamicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        _imageView = [[UIImageView alloc] init];
//        _titiLabel = [[UILabel alloc] init];
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = 70;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        [self.contentView addSubview:_imageView];
//        [self.contentView addSubview:_titiLabel];
        [self.contentView addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel
{
    _dynamicModel = dynamicModel;
    _contentLabel.text= dynamicModel.content;
}

@end
