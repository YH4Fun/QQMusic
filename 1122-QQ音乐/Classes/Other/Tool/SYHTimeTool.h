//
//  SYHTimeTool.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYHTimeTool : NSObject

+ (NSString *)getFormatTimeWithTimeInterval:(float)timeInterval;

+ (float)getTimeIntervalWithFormatTime:(NSString *)format;
@end
