//
//  SYHQQDetialViewController.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHQQDetialViewController.h"
#import "UIView+Extension.h"
#import "SYHMusicOprationTool.h"
#import "SYHTimeTool.h"
#import "SYHLrcDataTool.h"
#import "SYHLrcTVC.h"
#import "SYHLrcLabel.h"

@interface SYHQQDetialViewController ()<UIScrollViewDelegate,AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *lrcBackView;
@property (weak, nonatomic) IBOutlet UIImageView *smallIcon;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;


@property (weak, nonatomic) IBOutlet SYHLrcLabel *lrcLabel;
@property (weak, nonatomic) IBOutlet UILabel *costTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

@property (nonatomic,weak)SYHLrcTVC *lrcTVC;

@property (nonatomic,strong)NSTimer *updateTimer;
@property (nonatomic,strong)CADisplayLink *link;


@end

@implementation SYHQQDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpInit];
}

/*************************以下为业务逻辑方法,需和外界交互,放在显眼的地方******************************/
- (IBAction)moreBtn:(id)sender
{
    NSLog(@"更多");
}

- (IBAction)closeBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)playOrPause:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [[SYHMusicOprationTool sharedSYHMusicOprationTool] playCurrentMusic];
        [self resumeRotation];
    }else{
        [[SYHMusicOprationTool sharedSYHMusicOprationTool] pasueCurrentMusic];
        [self pauseRotation];
    }
}

- (IBAction)preMusicBtn:(UIButton *)sender
{
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] preMusic];
    [self setUpOnce];
}
- (IBAction)nextMusicBtn:(UIButton *)sender
{
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] nextMusic];
    [self setUpOnce];
}

- (IBAction)touchDown {
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}
- (IBAction)touchUp {
    [self updateTimer];
    SYHMusicMessageModel *msgM = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    
    NSTimeInterval currentTime = self.progressSlider.value * msgM.totalTime;
    
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] seekToTimeInterval:currentTime];
}
- (IBAction)valueChange:(UISlider *)sender {
    SYHMusicMessageModel *msgM = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    
    NSTimeInterval currentTime = self.progressSlider.value * msgM.totalTime;
    
    self.costTimeLabel.text = [SYHTimeTool getFormatTimeWithTimeInterval:currentTime];
}
// 点按手势触发
- (IBAction)seekToTime:(UITapGestureRecognizer *)sender {
    SYHMusicMessageModel *msgM = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    
    CGPoint point = [sender locationInView:self.progressSlider];
    float scale = point.x / self.progressSlider.width;
    self.progressSlider.value = scale;
    NSTimeInterval currentTime = scale * msgM.totalTime;
    self.costTimeLabel.text = [SYHTimeTool getFormatTimeWithTimeInterval:currentTime];
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] seekToTimeInterval:currentTime];
    
}


/**********************************初始化设置,以下方法不涉及业务逻辑,基本只需要设置一次****************************************/

- (void)setUpOnce
{
    SYHMusicMessageModel *msgModel = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    self.smallIcon.image = [UIImage imageNamed:msgModel.musicM.icon];
    self.backImageView.image = [UIImage imageNamed:msgModel.musicM.icon];
    self.songNameLabel.text = msgModel.musicM.name;
    self.singerLabel.text = msgModel.musicM.singer;
    self.totalTimeLabel.text = [SYHTimeTool getFormatTimeWithTimeInterval:msgModel.totalTime];
    
    //加载歌曲对应的歌词数组
    NSArray *lrcMs = [SYHLrcDataTool getLrcModelsWithFileName:msgModel.musicM.lrcname];
    self.lrcTVC.lrcMs = lrcMs;
    
    // 旋转图片
    [self beginRotain];
    if (msgModel.isPlaying) {
        NSLog(@"正在播放");
        [self resumeRotation];
    }else{
        NSLog(@"暂停播放");
        [self pauseRotation];
    }
    
}

- (void)setUpTimes
{
    SYHMusicMessageModel *msgModel = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    self.costTimeLabel.text  = [SYHTimeTool getFormatTimeWithTimeInterval:msgModel.costTime];
    self.progressSlider.value = msgModel.costTime/msgModel.totalTime;
    self.playOrPauseBtn.selected = msgModel.isPlaying;
}

- (void)upDataLrc
{
    SYHMusicMessageModel *msgModel = [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMsgModel;
    NSInteger row = [SYHLrcDataTool getRowWithCurrentTime:msgModel.costTime andLrcMs:self.lrcTVC.lrcMs];
    self.lrcTVC.scrollRow = row;
    
    SYHLrcModel *lrcM = self.lrcTVC.lrcMs[row];
    self.lrcLabel.text = lrcM.lrcText;
//    NSLog(@"%f",(msgModel.costTime - lrcM.beginTime)/(lrcM.endTime - lrcM.beginTime));
    
    self.lrcLabel.progress = (msgModel.costTime - lrcM.beginTime)/(lrcM.endTime - lrcM.beginTime);
    
    self.lrcTVC.progress = self.lrcLabel.progress;
    
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] upDataLockScreenMessage];
    
}

- (void)setUpInit
{
//    UITableView *tableView = [[UITableView alloc] init];
//    tableView.backgroundColor = [UIColor clearColor];
    [self.lrcBackView addSubview:self.lrcTVC.tableView];
    
    self.lrcBackView.pagingEnabled = YES;
    self.lrcBackView.showsHorizontalScrollIndicator = NO;

    self.lrcBackView.delegate = self;
    
    self.smallIcon.layer.masksToBounds = YES;
    self.smallIcon.layer.borderColor = [UIColor purpleColor].CGColor;
    self.smallIcon.layer.borderWidth = 5;
    
    //设置滑块图片
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    
    //设置播放工具类代理
    [SYHMusicOprationTool sharedSYHMusicOprationTool].delegate = self;
}

- (void)beginRotain
{
    [self.smallIcon.layer removeAnimationForKey:@"smallIconAnimation"];
    CABasicAnimation *anim = [[CABasicAnimation alloc] init];
    anim.keyPath = @"transform.rotation.z";
    anim.fromValue = @(0);
    anim.toValue = @(M_PI * 2);
    anim.duration = 30;
    anim.repeatCount = MAXFLOAT;
    [self.smallIcon.layer addAnimation:anim forKey:@"smallIconAnimation"];
}

- (void)pauseRotation
{
    [self.smallIcon.layer pauseAnimate];
}

- (void)resumeRotation
{
    [self.smallIcon.layer resumeAnimate];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = 1 - scrollView.contentOffset.x / scrollView.width;
    self.lrcLabel.alpha = scale;
    self.smallIcon.alpha = scale;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.lrcTVC.tableView.frame = self.lrcBackView.bounds;
    self.lrcTVC.tableView.x = self.lrcBackView.width;
    // 设置scrollView的contentSize
    self.lrcBackView.contentSize = CGSizeMake(self.lrcBackView.bounds.size.width*2, 0);
    
    self.smallIcon.layer.cornerRadius = self.smallIcon.bounds.size.width*0.5;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpOnce];
    [self updateTimer];
    [self link];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
    [self.link invalidate];
    self.link = nil;
}

- (NSTimer *)updateTimer
{
    if (!_updateTimer) {
        _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setUpTimes) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_updateTimer forMode:NSRunLoopCommonModes];
    }
    return _updateTimer;
}

-(CADisplayLink *)link
{
    if (_link == nil) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(upDataLrc)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

- (SYHLrcTVC *)lrcTVC
{
    if (_lrcTVC == nil) {
        SYHLrcTVC *tvc = [[SYHLrcTVC alloc] init];
        [self addChildViewController:tvc];
        _lrcTVC = tvc;
    }
    return _lrcTVC;
}
/********************************接收远程事件(系统自动调用)******************************************/
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
            NSLog(@"播放-----远程事件接收");
            [[SYHMusicOprationTool sharedSYHMusicOprationTool] playCurrentMusic];
            break;
            
        case UIEventSubtypeRemoteControlPause:
            NSLog(@"暂停");
            [[SYHMusicOprationTool sharedSYHMusicOprationTool] pasueCurrentMusic];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            NSLog(@"下一首");
            [[SYHMusicOprationTool sharedSYHMusicOprationTool] nextMusic];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            NSLog(@"上一首");
            [[SYHMusicOprationTool sharedSYHMusicOprationTool] preMusic];
            break;
            
        default:
            break;
    }
    [self setUpOnce];
    
}

#pragma mark - 音乐播放完成代理方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"本首歌曲播放完毕");
    [self nextMusicBtn:nil];
}

@end
