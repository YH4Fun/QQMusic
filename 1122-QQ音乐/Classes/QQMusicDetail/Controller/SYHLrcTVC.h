//
//  SYHLrcTVC.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYHLrcModel.h"

@interface SYHLrcTVC : UITableViewController

@property (nonatomic,strong)NSArray <SYHLrcModel *>*lrcMs;
@property (nonatomic, assign) NSInteger scrollRow;

@property (nonatomic, assign) float progress;
@end
