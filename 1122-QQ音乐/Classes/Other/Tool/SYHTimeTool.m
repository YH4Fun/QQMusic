//
//  SYHTimeTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHTimeTool.h"

@implementation SYHTimeTool

+(NSString *)getFormatTimeWithTimeInterval:(float)timeInterval
{
    NSInteger min = timeInterval / 60;
    NSInteger sec = (NSInteger)timeInterval % 60;
    return [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
}

+ (float)getTimeIntervalWithFormatTime:(NSString *)format
{
    // 03:19.22
    NSArray *timeArr = [format componentsSeparatedByString:@":"];
    NSString *min = [timeArr firstObject];
    NSString *sec = [timeArr lastObject];
    return min.floatValue * 60 + sec.floatValue;
}

@end
