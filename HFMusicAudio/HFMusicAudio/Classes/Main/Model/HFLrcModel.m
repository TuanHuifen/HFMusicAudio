//
//  HFLrcModel.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFLrcModel.h"

@implementation HFLrcModel

+ (instancetype )lrcDataWithString:(NSString *)str{
    
   return [[self alloc] initWithFileName:str];
}

- (instancetype)initWithFileName:(NSString *)name{
    if (self = [super init]) {
        NSArray *lrcArray = [name componentsSeparatedByString:@"]"];
        self.text = lrcArray[1];
        self.time = [self getTimeIntervalWithTimeStr:[lrcArray[0] substringFromIndex:1]];
    }
    return self;
}

- (NSTimeInterval)getTimeIntervalWithTimeStr:(NSString *)timeStr{
//    00:00.89
    NSString * min = [timeStr componentsSeparatedByString:@":"][0];
    NSString * sec = [timeStr substringWithRange:NSMakeRange(3, 2)];
    NSString * ms = [timeStr componentsSeparatedByString:@"."][1];
//    return [min intValue] * 60 + [sec intValue] + [ms intValue] * 0.001;
//    毫秒和秒的换算是1000为什么如果是1000的话，感觉歌词出现的有点早
    return [min intValue] * 60 + [sec intValue] + [ms intValue] * 0.01;

}
@end
