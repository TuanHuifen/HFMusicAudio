//
//  HFLrcScrollView.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFLrcLab.h"

@interface HFLrcScrollView : UIScrollView
//当前播放的进度时间
@property (nonatomic,assign) NSTimeInterval currentTime;
//歌词文件名
@property (nonatomic,copy) NSString * lrcName;
//当前歌词lab
@property (nonatomic,strong) HFLrcLab * lrcLab;

@end
