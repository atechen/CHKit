//
//  DynamicTableViewCell.m
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import "DynamicTableViewCell.h"

@interface DynamicTableViewCell ()
//{
//    UILabel *_nameLabel;
//    UIImageView *_headerImage;
//    UILabel *_contentLabel;
//}
@end

@implementation DynamicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
        _headerImage = [[UIImageView alloc] init];
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_headerImage];
        [self.contentView addSubview:_contentLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10));
            make.right.equalTo(@(-10));
            make.top.equalTo(@(5));
        }];
        
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10));
            make.right.equalTo(@(-10));
            make.top.equalTo(_nameLabel.mas_bottom).equalTo(@10);
            make.height.equalTo(@(50));
        }];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(10));
            make.right.equalTo(@(-10));
            make.top.equalTo(_headerImage.mas_bottom).equalTo(@(10));
            make.bottom.equalTo(@(-5));
        }];
        
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel
{
    _dynamicModel = dynamicModel;
    _nameLabel.text = dynamicModel.hname;
    _contentLabel.text= dynamicModel.rcont;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dynamicModel.himgurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [_headerImage mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@(image.size.height));
//        }];
    }];
}

@end
