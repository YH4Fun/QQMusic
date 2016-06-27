//
//  SYHImageTool.m
//  1122-QQ音乐
//
//  Created by 孙英豪 on 15/11/24.
//  Copyright © 2015年 孙英豪. All rights reserved.
//

#import "SYHImageTool.h"

@implementation SYHImageTool

+(UIImage *)createImageWithText:(NSString *)text inImage:(UIImage *)image
{
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{
                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:20],
                                 NSParagraphStyleAttributeName : style,
                                 };
    
    [text drawInRect:CGRectMake(0, 0, image.size.width, 26) withAttributes:dic];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
