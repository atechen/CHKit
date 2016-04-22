//
//  DynamicCellHeightController.m
//  CHKit
//
//  Created by 陈 斐 on 16/3/11.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "DynamicSelfSizeController.h"
#import "AutoLayoutTableViewCell.h"
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
    
    YYFPSLabel *fpsLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
    self.navigationItem.titleView = fpsLabel;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TestJSONData" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:nil];
    _dataArr = [DynamicModel mj_objectArrayWithKeyValuesArray:testDict[@"reply"]];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.separatorColor = [UIColor redColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.tableView registerClass:[AutoLayoutTableViewCell class] forCellReuseIdentifier:dynamicCellID];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicCellID forIndexPath:indexPath];
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
