//
//  SYHMusicTableViewCell.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SYHMusicModel;
@interface SYHMusicTableViewCell : UITableViewCell

@property (nonatomic,strong)SYHMusicModel *musicM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
