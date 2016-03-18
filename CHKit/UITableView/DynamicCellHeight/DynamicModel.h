//
//  DynamicModel.h
//  CHKit
//
//  Created by mac on 16/3/12.
//  Copyright (c) 2016年 atechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicModel,ImageModel;

@interface DynamicModel : NSObject

@property (nonatomic, copy) NSString *hname;

@property (nonatomic, copy) NSString *himgurl;

@property (nonatomic, copy) NSString *rcont;

@property (nonatomic, strong) NSArray<ImageModel *> *rurl;

@end

@interface ImageModel : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@end

