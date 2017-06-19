//
//  HFLrcModel.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFLrcModel : NSObject
@property (nonatomic,copy) NSString * text;
@property (nonatomic,assign) NSTimeInterval time;

+ (instancetype )lrcDataWithString:(NSString *)str;
@end
