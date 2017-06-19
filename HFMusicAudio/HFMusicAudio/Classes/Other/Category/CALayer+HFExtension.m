//
//  CALayer+HFExtension.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "CALayer+HFExtension.h"

@implementation CALayer (HFExtension)
- (void)pauseLayer
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

//继续layer上面的动画
- (void)resumeLayer
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}
@end
