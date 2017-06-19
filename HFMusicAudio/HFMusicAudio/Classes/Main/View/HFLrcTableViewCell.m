//
//  HFLrcTableViewCell.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/16.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFLrcTableViewCell.h"
#import <Masonry.h>


@implementation HFLrcTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView{
    static NSString * cellId = @"cellId";
    HFLrcTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HFLrcTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        HFLrcLab * lab = [[HFLrcLab alloc]init];
        self.lrcLab = lab;
        [self.contentView addSubview:lab];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor clearColor];
        
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor whiteColor];
    }
    return self;
}
@end
