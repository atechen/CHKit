//
//  CalculateInCellController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/11.
//  Copyright © 2016年 atechen. All rights reserved.
//

/*
 在只使用估算的方案中，是否需要每次赋值的时候都计算高度
 （1）若使用autolayout，在赋值的时候如何设置子视图的布局
 （2）可否在heightForRowAtIndexPath中获取cell，更新约束或子视图布局。
	这样的话每个cell只需要计算一次行高即可。
	在cell对象中将赋值和计算高度分开，在cellForRowAtIndexPath中判断高度是否缓存，缓存的话只赋值不计算高度，在heightForRowAtIndexPath中获取cell直接更新约束（或layouSubView）
 */

#import "EstimateAndCalculateController.h"
#import "FrameResizeTableViewCell.h"
#import "DynamicModel.h"

@interface EstimateAndCalculateController ()
{
    NSArray *_dataArr;
    NSMutableDictionary *_cellHeightDic;
}
@end

@implementation EstimateAndCalculateController
static NSString *calculteCellID = @"dynamicAndCalculateInCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    self.navigationItem.titleView = fpsLabel;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestJSONData" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:nil];
    _dataArr = [DynamicModel mj_objectArrayWithKeyValuesArray:testDict[@"reply"]];
    
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerClass:[FrameResizeTableViewCell class] forCellReuseIdentifier:calculteCellID];
    
    _cellHeightDic = [NSMutableDictionary dictionary];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FrameResizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:calculteCellID forIndexPath:indexPath];
    CGFloat cellHeight = [cell setDynamicModelAndCalculateheight:_dataArr[indexPath.row]];
    if (!_cellHeightDic[indexPath]) {
        [_cellHeightDic setObject:@(cellHeight) forKey:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_cellHeightDic[indexPath] floatValue];
}

@end
