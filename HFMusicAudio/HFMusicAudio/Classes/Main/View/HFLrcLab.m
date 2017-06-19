//
//  HFLrcLab.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFLrcLab.h"

@implementation HFLrcLab

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGRect fileRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    [[UIColor yellowColor] set];
    UIRectFillUsingBlendMode(fileRect, kCGBlendModeSourceIn);

}


@end
