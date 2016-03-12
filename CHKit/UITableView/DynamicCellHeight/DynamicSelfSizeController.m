//
//  DynamicCellHeightController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/11.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "DynamicSelfSizeController.h"
#import "DynamicTableViewCell.h"
#import "DynamicModel.h"

@interface DynamicSelfSizeController ()
{
    NSArray *_dataArr;
}
@end

@implementation DynamicSelfSizeController
static NSString *dynamicCellID = @"dynamicCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestJSONData" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:nil];
    _dataArr = [DynamicModel mj_keyValuesArrayWithObjectArray:testDict[@"results"]];
    
    self.tableView.estimatedRowHeight = 44;
    
    [self.tableView registerClass:[DynamicTableViewCell class] forCellReuseIdentifier:dynamicCellID];
    
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
    DynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellID forIndexPath:indexPath];
    cell.dynamicModel = _dataArr[indexPath.row];
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
