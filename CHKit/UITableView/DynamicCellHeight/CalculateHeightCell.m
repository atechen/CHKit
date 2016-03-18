//
//  CalculateHeightCell.m
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import "CalculateHeightCell.h"

@implementation CalculateHeightCell

- (CGFloat) calculateHeightWithInfo:(DynamicModel *)dynamicModel
{
    return CGRectGetMaxY(_contentLabel.frame) + 10;
    return self.frame.size.height;
}

@end
