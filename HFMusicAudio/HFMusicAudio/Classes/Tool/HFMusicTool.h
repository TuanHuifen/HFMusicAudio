//
//  HFMusicTool.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFMusicModel.h"

@interface HFMusicTool : NSObject
// 所有音乐
+ (NSArray *)musics;

//获取正在播放的音乐
+ (HFMusicModel *)playingMusic;

+ (HFMusicModel *)nextMusic;

+ (HFMusicModel *)previousMusic;

//设为默认音乐
+ (void)setUpDefaultMusicWithData:(HFMusicModel *)model;
@end
