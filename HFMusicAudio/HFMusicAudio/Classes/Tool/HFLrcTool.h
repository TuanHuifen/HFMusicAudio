//
//  HFLrcTool.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HFLrcTool : NSObject

//获取歌词
+ (NSArray *)getLrcDataWithFileName:(NSString *)fileName;

@end
