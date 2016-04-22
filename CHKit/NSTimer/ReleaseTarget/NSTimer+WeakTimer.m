//
//  NSTimer+WeakTimer.m
//  CHKit
//
//  Created by 陈 斐 on 16/4/14.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "NSTimer+WeakTimer.h"

@implementation NSTimer (WeakTimer)

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo
{
    void (^targetBlock)() = [block copy];
    return [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerSelector:) userInfo:targetBlock repeats:yesOrNo];
}

+ (id)timerWithTimeInterval:(NSTimeInterval)timeInterval block:(void (^)())block repeats:(BOOL)yesOrNo
{
    void (^targetBlock)() = [block copy];
    return [self timerWithTimeInterval:timeInterval target:self selector:@selector(timerSelector:) userInfo:targetBlock repeats:yesOrNo];
}

+ (void) timerSelector:(NSTimer *)timer
{
    if (timer.userInfo) {
        void (^targetBlock)() = (void (^)()) timer.userInfo;
        targetBlock();
    }
}

#pragma mark - Timer控制
- (void) pauseTimer
{
    self.fireDate = [NSDate distantFuture];
}

- (void) resumeTimer
{
    self.fireDate = [NSDate date];
}




@end
