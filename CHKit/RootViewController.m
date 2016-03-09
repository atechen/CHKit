//
//  ViewController.m
//  CHKit
//
//  Created by 陈 斐 on 16/2/26.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "RootViewController.h"
#import "CollectionViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
        {
//            CGFloat marginBorderH = 10;
//            CGFloat marginSpaceH = 10;
//            int itemNumInRow = 4;
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//            CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
//            CGFloat itemWidth = (screenWidth - 2*marginBorderH - (itemNumInRow-1)*marginSpaceH)/4;
//            [flowLayout setItemSize:CGSizeMake(itemWidth,itemWidth)]; //设置每个cell显示数据的宽和高必须
            //cell间距
            flowLayout.minimumInteritemSpacing = 0.0f;
            //cell行距
            flowLayout.minimumLineSpacing = 0.0f;
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
//            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            controller = [[CollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            
            break;
        }
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
