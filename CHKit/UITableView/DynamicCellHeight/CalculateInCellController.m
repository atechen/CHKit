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

#import "CalculateInCellController.h"
#import "CalculateHeightCell.h"
#import "DynamicModel.h"

@interface CalculateInCellController ()
{
    NSArray *_dataArr;
}
@end

@implementation CalculateInCellController
static NSString *calculteCellID = @"dynamicAndCalculateInCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestJSONData" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:nil];
    _dataArr = [DynamicModel mj_keyValuesArrayWithObjectArray:testDict[@"results"]];
    
    self.tableView.estimatedRowHeight = 44;
    
    [self.tableView registerClass:[CalculateHeightCell class] forCellReuseIdentifier:calculteCellID];
    
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalculateHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:calculteCellID forIndexPath:indexPath];
    cell.dynamicModel = _dataArr[indexPath.row];
    [cell calculateHeightWithInfo:_dataArr[indexPath.row]];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"heightForRowAtIndexPath----%ld", (long)indexPath.row);
//    return 80;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"estimatedHeightForRowAtIndexPath----%ld", (long)indexPath.row);
//    return 44;
//}
@end
