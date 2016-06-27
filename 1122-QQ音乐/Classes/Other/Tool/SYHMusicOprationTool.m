//
//  SYHMusicOprationTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SYHMusicOprationTool.h"
#import "SYHAudioTool.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SYHImageTool.h"
#import "SYHLrcDataTool.h"

@implementation SYHMusicMessageModel

@end

@interface SYHMusicOprationTool ()

@property (nonatomic,strong)SYHAudioTool *audioTool;

@property (nonatomic, assign) NSInteger currentPlayIndex;
//SYHAudioTool *audioTool 类指着AVAudioPlayer *currenPlayer,而SYHMusicOprationTool类又指着SYHAudioTool,所以此处用弱指针
@property (nonatomic ,weak) AVAudioPlayer *currenPlayer;

@end

@implementation SYHMusicOprationTool

@synthesize musicMsgModel = _musicMsgModel;
single_implementation(SYHMusicOprationTool)

-(SYHMusicMessageModel *)musicMsgModel
{
    if (!_musicMsgModel) {
        _musicMsgModel = [[SYHMusicMessageModel alloc] init];
    }
    //保持信息的最新状态,外界通过getter方法拿到_musicMsgModel模型取出其中的播放信息
    SYHMusicModel *musicModel = self.musicMs[self.currentPlayIndex];
    
    _musicMsgModel.musicM = musicModel;
    _musicMsgModel.costTime = self.currenPlayer.currentTime;
    _musicMsgModel.totalTime = self.currenPlayer.duration;
    _musicMsgModel.isPlaying = self.currenPlayer.isPlaying;
    
    return _musicMsgModel;
}

- (void)setCurrentPlayIndex:(NSInteger)currentPlayIndex
{
    if (currentPlayIndex < 0) {
        currentPlayIndex = self.musicMs.count - 1;
    }
    if(currentPlayIndex > self.musicMs.count - 1){
        currentPlayIndex = 0;
    }
    _currentPlayIndex = currentPlayIndex;
}

- (SYHAudioTool *)audioTool
{
    if (!_audioTool) {
        _audioTool = [[SYHAudioTool alloc] init];
    }
    return _audioTool;
}

-(void)playMusicWithMusicModel:(SYHMusicModel *)musicM
{
    self.currenPlayer = [self.audioTool playAudioWithFileName:musicM.filename];
    NSArray *filenNmes = [self.musicMs valueForKeyPath:@"filename"];
    self.currentPlayIndex = [filenNmes indexOfObject:musicM.filename];
}



- (void)pasueCurrentMusic
{
    [self.audioTool pauseAudio];
}

- (void)playCurrentMusic
{
    SYHMusicModel *musicModel = self.musicMs[self.currentPlayIndex];
    [self playMusicWithMusicModel:musicModel];
}

- (void)nextMusic
{
    self.currentPlayIndex++;
    SYHMusicModel *musicModel = self.musicMs[self.currentPlayIndex];
    [self playMusicWithMusicModel:musicModel];
}

-(void)preMusic
{
    self.currentPlayIndex--;
    SYHMusicModel *musicModel = self.musicMs[self.currentPlayIndex];
    [self playMusicWithMusicModel:musicModel];
}

- (void)upDataLockScreenMessage
{
    
    SYHMusicMessageModel *musicMsgMdoel = self.musicMsgModel;
    MPNowPlayingInfoCenter *center  = [MPNowPlayingInfoCenter defaultCenter];
    
    UIImage *image = [UIImage imageNamed:musicMsgMdoel.musicM.icon];
    
    NSArray *lrcMs = [SYHLrcDataTool getLrcModelsWithFileName:musicMsgMdoel.musicM.lrcname];
    NSInteger row = [SYHLrcDataTool getRowWithCurrentTime:musicMsgMdoel.costTime andLrcMs:lrcMs];
    SYHLrcModel *lrcM = lrcMs[row];
    
    image = [SYHImageTool createImageWithText:lrcM.lrcText inImage:image];
    
    MPMediaItemArtwork *art = [[MPMediaItemArtwork alloc] initWithImage:image];
    NSDictionary *dic = @{
                          MPMediaItemPropertyAlbumTitle : musicMsgMdoel.musicM.name,
                          MPMediaItemPropertyPlaybackDuration : @(musicMsgMdoel.totalTime),
                          MPNowPlayingInfoPropertyElapsedPlaybackTime : @(musicMsgMdoel.costTime),
                          MPMediaItemPropertyArtist : musicMsgMdoel.musicM.singer,
                          MPMediaItemPropertyArtwork : art,
                          };
    center.nowPlayingInfo = dic;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

// 拖动滑块播放
- (void)seekToTimeInterval:(NSTimeInterval)currentTime
{
    [self.audioTool seekToTimeInterval:currentTime];
}

- (void)setDelegate:(id<AVAudioPlayerDelegate>)delegate
{
    self.audioTool.delegate = delegate;
}

@end



