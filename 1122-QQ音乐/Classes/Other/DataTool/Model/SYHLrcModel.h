//
//  SYHLrcModel.h
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/23.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYHLrcModel : NSObject

@property (nonatomic, assign) float beginTime;
@property (nonatomic, assign) float endTime;
// 每一句歌词
@property (nonatomic, copy) NSString *lrcText;


@end
