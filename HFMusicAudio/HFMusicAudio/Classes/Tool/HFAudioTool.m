//
//  HFAudioTool.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFAudioTool.h"


@interface HFAudioTool ()
////正在播放的模型
//@property (nonatomic,strong) HFMusicModel * playingModel;
//@property (nonatomic,strong) NSArray * musicArr;

@end

@implementation HFAudioTool
static NSMutableDictionary * _players;
static NSMutableDictionary * _sounds;

+ (void)initialize
{
    _players = [NSMutableDictionary dictionary];
    _sounds = [NSMutableDictionary dictionary];
}


+(AVAudioPlayer *)playMusicWithName:(NSString *)name{
    AVAudioPlayer * player = nil;
    player = _players[name];
    if (player == nil) {
        NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
        if (fileUrl == nil) {
            return nil;
        }
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
        [_players setObject:player forKey:name];
        [player prepareToPlay];
    }
    [player play];

    return player;
}

+ (void)pauseMusicWithName:(NSString *)name{
    AVAudioPlayer * player = _players[name];
    if (player) {
        [player stop];
        [_players removeObjectForKey:player];
        player = nil;
    }
}





@end
