//
//  DynamicTableViewCell.h
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"
@interface AutoLayoutTableViewCell : UITableViewCell
@property (nonatomic, strong) DynamicModel *dynamicModel;
@end
