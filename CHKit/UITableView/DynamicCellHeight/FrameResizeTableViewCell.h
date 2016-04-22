//
//  FrameResizeTableViewCell.h
//  CHKit
//
//  Created by 陈 斐 on 16/3/21.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DynamicModel.h"

@interface FrameResizeTableViewCell : UITableViewCell
{
    UILabel *_nameLabel;
    UIImageView *_headerImage;
    UILabel *_contentLabel;
}
- (CGFloat)setDynamicModelAndCalculateheight:(DynamicModel *)dynamicModel;
@end
