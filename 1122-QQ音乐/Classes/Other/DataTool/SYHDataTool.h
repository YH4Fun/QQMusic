//
//  SYHDataTool.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYHMusicModel.h"

@interface SYHDataTool : NSObject

+ (void)getMusicDatas:(void(^)(NSArray <SYHMusicModel *>*musicModels))ResultBlock;

@end
