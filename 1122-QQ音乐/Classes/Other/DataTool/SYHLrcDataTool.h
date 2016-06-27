//
//  SYHLrcDataTool.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYHLrcModel.h"


@interface SYHLrcDataTool : NSObject

+ (NSArray <SYHLrcModel *>*)getLrcModelsWithFileName:(NSString *)filename;

+ (NSInteger)getRowWithCurrentTime:(NSTimeInterval)currentTime andLrcMs:(NSArray <SYHLrcModel *>*)lrcMs;

@end
