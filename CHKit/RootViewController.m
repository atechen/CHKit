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
{
    NSArray *_sectionArr;
}
@end

@implementation RootViewController
static NSString *rootTableViewCellID = @"rootTableViewCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kitList" ofType:@"plist"]] ;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootTableViewCellID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = _sectionArr[section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    return sectionArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rootTableViewCellID];
    NSDictionary *sectionDic = _sectionArr[indexPath.section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    cell.textLabel.text = sectionArr[indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = _sectionArr[section];
    return sectionDic[@"sectionName"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = _sectionArr[indexPath.section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    NSString *className = sectionArr[indexPath.row][@"class"];
    int flag = [sectionArr[indexPath.row][@"flag"] intValue];
    Class detailClass = NSClassFromString(className);
    
    UIViewController *controller;
    switch (flag) {
        case 0:
        {
            controller = [[detailClass alloc] init];
            break;
        }
        case 1:
        {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            //cell间距
            flowLayout.minimumInteritemSpacing = 0.0f;
            //cell行距
            flowLayout.minimumLineSpacing = 0.0f;
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            controller = [[CollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            
            break;
        }
            
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
