//
//  HFLrcTool.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFLrcTool.h"
#import "HFLrcModel.h"
@implementation HFLrcTool

+ (NSArray *)getLrcDataWithFileName:(NSString *)fileName{
    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    NSString * contentStr = [NSString stringWithContentsOfURL:fileUrl encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray * lrcArr = [NSMutableArray array];
    NSArray * arr = [contentStr componentsSeparatedByString:@"\n"];
    for (NSString * str in arr) {
        if ([str hasPrefix:@"[ti:"] ||[str hasPrefix:@"[ar:"]||[str hasPrefix:@"[al:"]||![str hasPrefix:@"["]) {
            continue;
        }
        HFLrcModel * lrcModel = [HFLrcModel lrcDataWithString:str];
       [ lrcArr addObject:lrcModel];
    }
    return lrcArr;
}

@end
