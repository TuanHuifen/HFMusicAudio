//
//  NSString+HFExtension.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HFExtension)

//返回格式   00：00
+ (NSString *)stringWithTime:(NSTimeInterval)time;
@end
