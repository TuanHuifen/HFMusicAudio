//
//  HFLrcTableViewCell.h
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFLrcLab.h"

@interface HFLrcTableViewCell : UITableViewCell

@property (nonatomic,strong) HFLrcLab * lrcLab;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;

@end
