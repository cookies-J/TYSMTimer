//
//  TYSMTimer.m
//  Pods-TYSMTimer_Example
//
//  Created by jele lam on 24/9/2020.
//

#import "TYSMTimer.h"

@implementation TYSMTimer
static int i = 0;

// 创建保存timer的容器
static NSMutableDictionary *timers;
dispatch_semaphore_t sem;

+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers = [NSMutableDictionary dictionary];
        sem = dispatch_semaphore_create(1);
    });
}
+(NSString *)timerWithTarget:(id)target selector:(SEL)selector StartTime:(NSTimeInterval)start interval:(NSTimeInterval)interval count:(NSTimeInterval)countInterval repeats:(BOOL)repeats mainQueue:(BOOL)async {
    if (!target || !selector) {
        return nil;
    }
    
    return [self timerWithStartTime:start interval:interval count:countInterval repeats:repeats mainQueue:async completion:^(NSTimeInterval interval) {
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector];
        }
    }];
}

+(NSString *)timerWithStartTime:(NSTimeInterval)start interval:(NSTimeInterval)interval count:(NSTimeInterval)countInterval repeats:(BOOL)repeats mainQueue:(BOOL)async completion:(void (^)(NSTimeInterval))completion {
    if (!completion || start < 0 ||  interval <= 0) {
        return nil;
    }
    // 创建定时器
    dispatch_queue_t queue = !async ? dispatch_queue_create("tysm_gcd_timer_queue", NULL) : dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue );
    // 设置时间,从 start 秒之后开始，interval 秒一次
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSString *timerId = [NSString stringWithFormat:@"TimerID: %d",i++];
    __block NSTimeInterval reverseInterval = countInterval;
    timers[timerId]=timer;
    dispatch_semaphore_signal(sem);
    // 回调
    dispatch_source_set_event_handler(timer, ^{
        if (completion) {
            completion(reverseInterval--);
        }
        // 不重复执行就取消timer 或者计数 <= 0
        if (repeats == NO ||
            reverseInterval < 0) {
            [self cancel:timerId];
        }
    });
    dispatch_resume(timer);
    
    return timerId;
}

+ (void)cancel:(NSString *)timerID{
    if (!timerID || timerID.length <= 0) {
        return;
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timers[timerID];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers removeObjectForKey:timerID];
    }
    dispatch_semaphore_signal(sem);
}
@end
