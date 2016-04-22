//
//  FrameResizeTableViewCell.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/21.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "FrameResizeTableViewCell.h"

@interface FrameResizeTableViewCell ()
{
    DynamicModel *_dynamicModel;
}

@end

@implementation FrameResizeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGSize selfSize = self.contentView.frame.size;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, selfSize.width - 20, 0)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_nameLabel];
        
//        _headerImage = [[UIImageView alloc] init];
//        [self.contentView addSubview:_headerImage];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameLabel.frame) + 10, selfSize.width - 20, 0)];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor yellowColor];
        _contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_contentLabel];
        
    }
    return self;
}

- (CGFloat)setDynamicModelAndCalculateheight:(DynamicModel *)dynamicModel
{
    _dynamicModel = dynamicModel;
    
    _nameLabel.text = dynamicModel.hname;
    CGRect nameLabelFrame = _nameLabel.frame;
    nameLabelFrame.size.height = [dynamicModel.hname boundingRectWithSize:CGSizeMake(_nameLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_nameLabel.font} context:nil].size.height;
    _nameLabel.frame = nameLabelFrame;
    
    _contentLabel.text= dynamicModel.rcont;
    CGRect contentLabelFrame = _contentLabel.frame;
    contentLabelFrame.size.height = [dynamicModel.rcont boundingRectWithSize:CGSizeMake(_contentLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_contentLabel.font} context:nil].size.height;
    contentLabelFrame.origin.y = CGRectGetMaxY(_nameLabel.frame) + 10;
    _contentLabel.frame = contentLabelFrame;
    return CGRectGetMaxY(_contentLabel.frame) + 5;
    
//    [_headerImage sd_setImageWithURL:[NSURL URLWithString:dynamicModel.himgurl]];
}


@end
