//
//  HFAudioTool.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HFMusicModel.h"
#import <AVFoundation/AVFoundation.h>

@interface HFAudioTool : NSObject


//播放音乐
+ (AVAudioPlayer *)playMusicWithName:(NSString *)name;

//暂停音乐
+ (void)pauseMusicWithName:(NSString *)name;



@end
