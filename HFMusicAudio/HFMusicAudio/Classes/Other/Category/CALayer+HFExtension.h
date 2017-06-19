//
//  CALayer+HFExtension.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (HFExtension)
//暂停动画
- (void)pauseLayer;

//继续layer上面的动画
- (void)resumeLayer;

@end
