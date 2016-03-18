//
//  MutiItemTableViewController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/10.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "MutiItemTableViewController.h"
#import "MutiItemTabelViewCell.h"

@interface MutiItemTableViewController ()
{
    NSMutableArray *_dataInfoArr;
    NSMutableDictionary *_cellHeightDic;
}
@end

@implementation MutiItemTableViewController
static NSString *mutiItemTabelViewCellID = @"mutiItemTabelViewCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerClass:[MutiItemTabelViewCell class] forCellReuseIdentifier:mutiItemTabelViewCellID];
    
    _cellHeightDic = [NSMutableDictionary dictionary];
    _dataInfoArr = [NSMutableArray array];
    for (int i = 0; i<20; i++) {
        int itemCountInsection = arc4random_uniform(20) + 1;
        NSMutableArray *itemArr = [NSMutableArray array];
        for (int j=0; j<itemCountInsection; j++) {
            [itemArr addObject:@(j)];
        }
        [_dataInfoArr addObject:itemArr];
    }
    
    self.tableView.separatorColor = [UIColor redColor];
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    self.navigationItem.titleView = fpsLabel;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataInfoArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MutiItemTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mutiItemTabelViewCellID forIndexPath:indexPath];
    // 赋值并计算高度
    [_cellHeightDic setObject:@([cell setItemInfoArr:_dataInfoArr[indexPath.row]]) forKey:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellHeightDic[indexPath] floatValue];
}

@end
