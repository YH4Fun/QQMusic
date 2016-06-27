//
//  SYHLrcCell.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/24.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLrcCell.h"
#import "SYHLrcLabel.h"

@interface SYHLrcCell ()
@property (weak, nonatomic) IBOutlet SYHLrcLabel *lrcLabel;


@end

@implementation SYHLrcCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *lrcCellID = @"lrc";
    SYHLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:lrcCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SYHLrcCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}

-(void)setLrcText:(NSString *)lrcText
{
    _lrcText = lrcText;
    self.lrcLabel.text = lrcText;
}

-(void)setProgress:(float)progress
{
    _progress = progress;
    self.lrcLabel.progress = progress;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
