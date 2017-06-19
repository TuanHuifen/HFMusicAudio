//
//  HFMusicTool.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFMusicTool.h"
#import <MJExtension.h>

@implementation HFMusicTool
static NSArray * _musicArr;
static HFMusicModel *_playingModel;

+ (void)initialize
{
    if (_musicArr == nil) {
        _musicArr = [HFMusicModel mj_objectArrayWithFilename:@"Musics.plist"];
    }
    
    if (_playingModel == nil) {
        _playingModel = _musicArr[1];
    }
    
}

+ (NSArray *)musics
{
    return _musicArr;
}

+ (HFMusicModel *)playingMusic{
    return _playingModel;
}

+ (HFMusicModel *)nextMusic{
    NSInteger index = [_musicArr indexOfObject:_playingModel];
//    NSInteger nextIndex = index++;
    NSInteger nextIndex = ++index;
    if (nextIndex >= _musicArr.count ) {
        nextIndex = 0;
    }
    HFMusicModel * model = _musicArr[nextIndex];
    return model;
}

+ (HFMusicModel *)previousMusic{
    NSInteger index = [_musicArr indexOfObject:_playingModel];
//    NSInteger preIndex = index--;
    NSInteger preIndex = --index;
    if (preIndex < 0) {
        preIndex = _musicArr.count - 1;
    }
    HFMusicModel * model = _musicArr[preIndex];
    return model;
}

+ (void)setUpDefaultMusicWithData:(HFMusicModel *)model{
    _playingModel =  model;
}


@end
