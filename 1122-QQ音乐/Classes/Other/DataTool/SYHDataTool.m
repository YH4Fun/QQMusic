//
//  SYHDataTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHDataTool.h"
#import "MJExtension.h"

@implementation SYHDataTool

+(void)getMusicDatas:(void (^)(NSArray<SYHMusicModel *> *musicModels))ResultBlock
{
 
    NSArray *array = [SYHMusicModel objectArrayWithFilename:@"Musics.plist"];
    ResultBlock([array arrayByAddingObjectsFromArray:array]);
}

@end
