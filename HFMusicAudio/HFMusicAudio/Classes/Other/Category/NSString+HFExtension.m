//
//  NSString+HFExtension.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "NSString+HFExtension.h"

@implementation NSString (HFExtension)


+ (NSString *)stringWithTime:(NSTimeInterval)time{
    NSInteger min = time / 60;
    NSInteger second = (int) round(time) % 60;
    return [NSString stringWithFormat:@"%.2ld:%.2ld",(long)min,(long)second];
}
@end
