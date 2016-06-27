//
//  SYHMusicTableViewCell.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/22.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHMusicTableViewCell.h"
#import "SYHMusicModel.h"

@interface SYHMusicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconIMV;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;

@end

@implementation SYHMusicTableViewCell

- (void)awakeFromNib {

    self.iconIMV.layer.cornerRadius = self.iconIMV.bounds.size.width*0.5;
    self.iconIMV.layer.masksToBounds = YES;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SYHMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SYHMusicTableViewCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(void)setMusicM:(SYHMusicModel *)musicM
{
    _musicM = musicM;
    self.iconIMV.image = [UIImage imageNamed:musicM.singerIcon];
    self.songNameLabel.text = musicM.name;
    self.singerNameLabel.text = musicM.singer;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.backgroundColor = [UIColor yellowColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
