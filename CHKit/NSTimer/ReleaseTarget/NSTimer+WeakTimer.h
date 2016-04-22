//
//  NSTimer+WeakTimer.h
//  CHKit
//
//  Created by 陈 斐 on 16/4/14.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WeakTimer)

// 构造对象
+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo;
+ (id)timerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo;

// Timer控制
- (void) pauseTimer;
- (void) resumeTimer;
@end
