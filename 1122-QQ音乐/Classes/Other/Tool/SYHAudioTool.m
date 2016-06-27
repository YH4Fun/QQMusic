//
//  SYHAudioTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHAudioTool.h"
#import <AVFoundation/AVFoundation.h>

@interface SYHAudioTool ()

@property (nonatomic,strong)AVAudioPlayer *player;
@property (nonatomic, copy) NSURL *currentPlayUrl;

@end

@implementation SYHAudioTool

- (instancetype)init
{
    if ([super init]) {
        [self playBack];
    }
    return self;
}


- (void)playBack
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
}

- (AVAudioPlayer *)playAudioWithFileName:(NSString *)filename
{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    if (url == nil) {
        return nil;
    }
    
    if ([self.currentPlayUrl.absoluteString isEqualToString:url.absoluteString]) {
        [self.player play];
        return self.player;
    }
    self.currentPlayUrl = url;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    BOOL a = [self.player prepareToPlay];
    NSLog(@"prepareToPlay------%d",a);
    [self.player play];
    return self.player;
}

-(void)pauseAudio
{
    [self.player pause];
}

-(void)stopAudio
{
    [self.player stop];
    self.player.currentTime = 0;
}

- (void)seekToTimeInterval:(NSTimeInterval)currentTime
{
    [self.player setCurrentTime:currentTime];
}

- (void)setDelegate:(id<AVAudioPlayerDelegate>)delegate
{
    self.player.delegate = delegate;
}


@end
