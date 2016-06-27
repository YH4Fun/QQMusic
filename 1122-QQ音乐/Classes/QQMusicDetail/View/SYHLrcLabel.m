//
//  SYHLrcLabel.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/24.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHLrcLabel.h"

@implementation SYHLrcLabel

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    CGRect fillRect = CGRectMake(0, 0, self.size.width * self.progress, self.size.height);
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
