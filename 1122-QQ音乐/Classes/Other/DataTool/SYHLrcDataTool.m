//
//  SYHLrcDataTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLrcDataTool.h"
#import "SYHTimeTool.h"

@implementation SYHLrcDataTool

+(NSArray<SYHLrcModel *> *)getLrcModelsWithFileName:(NSString *)filename
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    NSString *lrcContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
//    NSLog(@"%@",lrcContent);
    
    NSArray *lrcStrs = [lrcContent componentsSeparatedByString:@"\n"];
    NSMutableArray *lrcModelArray = [NSMutableArray arrayWithCapacity:lrcStrs.count];
    for (int i = 0; i < lrcStrs.count; i++) {
        NSString *timeAndLrc = lrcStrs[i];
        // 过滤垃圾歌词
        if ([timeAndLrc containsString:@"ti:"] || [timeAndLrc containsString:@"ar:"] ||[timeAndLrc containsString:@"al:"]) {
            continue;
        }
        
        timeAndLrc = [timeAndLrc stringByReplacingOccurrencesOfString:@"[" withString:@""];
        NSArray *timeAndLrcArray = [timeAndLrc componentsSeparatedByString:@"]"];
//        NSLog(@"%@",timeAndLrcArray);
        SYHLrcModel *lrcM = [[SYHLrcModel alloc] init];
        lrcM.beginTime = [SYHTimeTool getTimeIntervalWithFormatTime:[timeAndLrcArray firstObject]];
        lrcM.lrcText = [timeAndLrcArray lastObject];
        [lrcModelArray addObject:lrcM];
    }
    for (int i = 0; i < lrcModelArray.count; i++) {
        if (i == lrcModelArray.count - 1) {
            break;
        }
        SYHLrcModel *lrcM = lrcModelArray[i];
        SYHLrcModel *NextLrcM = lrcModelArray[i + 1];
        lrcM.endTime = NextLrcM.beginTime;
    }
    return lrcModelArray;
}

+ (NSInteger)getRowWithCurrentTime:(NSTimeInterval)currentTime andLrcMs:(NSArray<SYHLrcModel *> *)lrcMs
{
    for (int i =0; i < lrcMs.count; i++) {
        SYHLrcModel *lrcM = lrcMs[i];
        if (currentTime >= lrcM.beginTime && currentTime < lrcM.endTime) {
            return i;
        }
    }
    
    return 0;
}

@end
