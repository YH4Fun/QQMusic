//
//  SYHLrcCell.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/24.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYHLrcCell : UITableViewCell

@property (nonatomic, copy) NSString *lrcText;

@property (nonatomic, assign) float progress;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
