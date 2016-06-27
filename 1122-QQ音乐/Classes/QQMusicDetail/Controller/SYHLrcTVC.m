//
//  SYHLrcTVC.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLrcTVC.h"
#import "SYHLrcCell.h"


@interface SYHLrcTVC ()

@end

@implementation SYHLrcTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
}

- (void)setUpInit
{
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.height * 0.5, 0, self.tableView.height * 0.5, 0);
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.scrollRow inSection:0];
    SYHLrcCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.progress = _progress;

}

- (void)setLrcMs:(NSArray<SYHLrcModel *> *)lrcMs
{
    _lrcMs = lrcMs;
    [self.tableView reloadData];
}

- (void)setScrollRow:(NSInteger)scrollRow
{
    if (_scrollRow == scrollRow) {
        return;
    }
    
    _scrollRow = scrollRow;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:scrollRow inSection:0];
//    NSLog(@"%zd",scrollRow);
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcMs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SYHLrcCell *cell = [SYHLrcCell cellWithTableView:tableView];
    
    
    if (indexPath.row == self.scrollRow) {
        cell.progress = self.progress;
    }else{
        cell.progress = 0;
    }
    
    SYHLrcModel *lrcM = self.lrcMs[indexPath.row];
    cell.lrcText = lrcM.lrcText;
    
    
    
    return cell;
}




@end
