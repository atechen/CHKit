//
//  DynamicTableViewCell.h
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface DynamicTableViewCell : UITableViewCell
{
    UILabel *_nameLabel;
    UIImageView *_headerImage;
    UILabel *_contentLabel;
}
@property (nonatomic, strong) DynamicModel *dynamicModel;
@end
