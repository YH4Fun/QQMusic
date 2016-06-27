//
//  SYHMusicOprationTool.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYHMusicModel.h"
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>


@interface SYHMusicMessageModel : NSObject

@property (nonatomic,strong)SYHMusicModel *musicM;

@property (nonatomic, assign) float costTime;
@property (nonatomic, assign) float totalTime;
@property (nonatomic, assign) BOOL isPlaying;

@end


@interface SYHMusicOprationTool : NSObject
single_interface(SYHMusicOprationTool)

@property (nonatomic,strong,readonly)SYHMusicMessageModel *musicMsgModel;


@property (nonatomic,strong) NSArray <SYHMusicModel *>*musicMs;


- (void)playMusicWithMusicModel:(SYHMusicModel *)musicM;

- (void)pasueCurrentMusic;

- (void)playCurrentMusic;

- (void)preMusic;

- (void)nextMusic;

// 更新歌词时更新锁屏信息
- (void)upDataLockScreenMessage;
//拖动滑块播放
- (void)seekToTimeInterval:(NSTimeInterval)currentTime;
@property (nonatomic ,weak)id<AVAudioPlayerDelegate> delegate;

@end
