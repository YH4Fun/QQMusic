//
//  SYHAudioTool.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SYHAudioTool : NSObject

- (AVAudioPlayer *)playAudioWithFileName:(NSString *)filename;
- (void)pauseAudio;
- (void)stopAudio;

- (void)seekToTimeInterval:(NSTimeInterval)currentTime;
@property (nonatomic ,weak) id<AVAudioPlayerDelegate> delegate;

@end
