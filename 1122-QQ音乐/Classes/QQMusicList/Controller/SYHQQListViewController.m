//
//  SYHQQListViewController.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHQQListViewController.h"
#import "SYHMusicTableViewCell.h"
#import "SYHDataTool.h"
#import "SYHMusicModel.h"
#import "SYHMusicOprationTool.h"

@interface SYHQQListViewController ()

@property (nonatomic,strong)NSArray <SYHMusicModel *>*musicMs;


@end

@implementation SYHQQListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self setUpInin];
    
    
}

- (void)setUpInin
{
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageV.image = [UIImage imageNamed:@"QQListBack.jpg"];
    self.tableView.backgroundView = imageV;
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)loadData
{
    [SYHDataTool getMusicDatas:^(NSArray<SYHMusicModel *> *musicModels) {
        NSLog(@"%@",musicModels);
        self.musicMs = musicModels;
        // 告诉SYHMusicOprationTool单例播放列表
        [SYHMusicOprationTool sharedSYHMusicOprationTool].musicMs = musicModels;
    }];
}

-(void)setMusicMs:(NSArray<SYHMusicModel *> *)musicMs
{
    _musicMs = musicMs;
    [self.tableView reloadData];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.musicMs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYHMusicTableViewCell *cell = [SYHMusicTableViewCell cellWithTableView:tableView];

    SYHMusicModel *model = self.musicMs[indexPath.row];
    cell.musicM = model;
    
    // 设置动画
    [cell.layer removeAnimationForKey:@"animation"];
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
    anim.keyPath = @"transform.rotation.z";
    anim.duration = 0.5;
    anim.values = @[@(1),@(0),@(-1),@(0)];
    [cell.layer addAnimation:anim forKey:@"animation"];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
    SYHMusicModel *musicM = self.musicMs[indexPath.row];
    NSLog(@"%@",musicM.name);
    [[SYHMusicOprationTool sharedSYHMusicOprationTool] playMusicWithMusicModel:musicM];
    
    [self performSegueWithIdentifier:@"list2ditail" sender:nil];
}

@end
