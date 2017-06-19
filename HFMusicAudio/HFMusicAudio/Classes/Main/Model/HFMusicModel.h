//
//  HFMusicModel.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFMusicModel : NSObject
//歌曲名
@property (nonatomic,copy) NSString * name;
//歌曲文件MP3
@property (nonatomic,copy) NSString * filename;
//歌词名文件
@property (nonatomic,copy) NSString * lrcname;
//歌手
@property (nonatomic,copy) NSString * singer;
//歌手icon
@property (nonatomic,copy) NSString * singerIcon;
//歌手
@property (nonatomic,copy) NSString * icon;

@end
