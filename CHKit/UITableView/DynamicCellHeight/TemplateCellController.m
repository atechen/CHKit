//
//  TemplateCellController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/11.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "TemplateCellController.h"
#import "DynamicTableViewCell.h"
#import "DynamicModel.h"

/*
 1、
 尝试不使用AutoLayout，使用autoresizing和layoutsubview能否实现
 2、
 测试updateConstains和layoutsubview的默认实现，是不是根据提前设置好的布局自动调整子视图的位置和大小；还是不用调用这两个方法，父视图改变大小时，子视图根据提前设置到布局就可以自己调整。（这样的话Calculate方法，不用在heightForRowAtIndexPath方法中获取cell就可以实现每行cell计算一次）
 */

@interface TemplateCellController ()
{
    NSArray *_dataArr;
    DynamicTableViewCell *_templateCell;
    NSMutableDictionary *_cellHeightDic;
}
@end

@implementation TemplateCellController
static NSString *dynamicCellID = @"dynamicWithTemplateCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestJSONData" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:nil];
    _dataArr = [DynamicModel mj_objectArrayWithKeyValuesArray:testDict[@"reply"]];
    
    _templateCell = [[DynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dynamicCellID];
    _cellHeightDic = [NSMutableDictionary dictionary];
    
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerClass:[DynamicTableViewCell class] forCellReuseIdentifier:dynamicCellID];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath --- %ld", (long)indexPath.row);
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellID forIndexPath:indexPath];
    cell.dynamicModel = _dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cellHeightValue = _cellHeightDic[indexPath];
    if (cellHeightValue) {
        return [_cellHeightDic[indexPath] floatValue];
    }
    
    _templateCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(_templateCell.bounds));
    _templateCell.dynamicModel = _dataArr[indexPath.row];
    CGFloat cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    [_cellHeightDic setObject:@(cellHeight) forKey:indexPath];
    NSLog(@"heightForRowAtIndexPath ++++ %ld", (long)indexPath.row);
    return cellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"estimatedHeightForRowAtIndexPath----%ld", (long)indexPath.row);
//    return 44;
//}
@end
