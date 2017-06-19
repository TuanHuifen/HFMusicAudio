//
//  HFLrcScrollView.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFLrcScrollView.h"
#import "HFLrcTool.h"
#import "HFLrcModel.h"
#import "HFLrcTableViewCell.h"

@interface HFLrcScrollView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSArray * lrcArr;

@property (nonatomic,assign) int currentIndex;

@end

@implementation HFLrcScrollView
static NSString * cellId = @"cellId";
- (void)awakeFromNib{
    [super awakeFromNib];
    [self creatTableView];
    self.pagingEnabled = YES;
}

//初始化tableView
- (void)creatTableView{
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, 0,[UIScreen mainScreen].bounds.size.width, self.bounds.size.height)];
    [self addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height *0.5, 0, self.bounds.size.height *0.5, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.lrcArr.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HFLrcModel * model = self.lrcArr[indexPath.row];
    HFLrcTableViewCell * cell = [HFLrcTableViewCell lrcCellWithTableView:tableView];
    if (self.currentIndex == indexPath.row) {
        cell.lrcLab.font = [UIFont systemFontOfSize:17];
    }else{
        cell.lrcLab.font = [UIFont systemFontOfSize:14];
        cell.lrcLab.progress = 0;
    }
    cell.lrcLab.text = model.text;
    return cell;
}


- (void)setCurrentTime:(NSTimeInterval)currentTime{
    _currentTime = currentTime;
    
    for (int i = 0; i < self.lrcArr.count; i ++) {
        HFLrcModel * currentModel = self.lrcArr[i];
        
        int nextIndex = i + 1;
        HFLrcModel * nextModel = nil;
        if (nextIndex < self.lrcArr.count) {
            nextModel = self.lrcArr[nextIndex];
        }
        
        if (self.currentIndex == i) {
            CGFloat value = (currentTime - currentModel.time) / (nextModel.time - currentModel.time);
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            HFLrcTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.lrcLab.progress = value;
            self.lrcLab.progress = value;
//            如果播放的是当前行，就算的是每行的速度
             self.lrcLab.text = currentModel.text;
        }
        if (self.currentIndex !=i && currentTime >= currentModel.time && currentTime < nextModel.time) {
            // 1.获取当前这句歌词和上一句歌词的IndexPath
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            
            // 2.记录当前刷新的某行
            self.currentIndex = i;
            
            // 3.刷新当前这句歌词,并且刷新上一句歌词
            [self.tableView reloadRowsAtIndexPaths:@[indexPath,previousIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 4.将当前的这句歌词滚动到中间
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];

//            显示当前行
            self.lrcLab.text = currentModel.text;
            
        }
        
        
    }
}

- (void)setLrcName:(NSString *)lrcName{
    self.currentIndex = 0;
    [self.tableView setContentOffset:CGPointMake(0, -self.tableView.bounds.size.height * 0.5) animated:NO];
    _lrcName = [lrcName copy];
    self.lrcArr = [HFLrcTool getLrcDataWithFileName:lrcName];
//    默认显示第一句歌词
    HFLrcModel * model = self.lrcArr[0];
    self.lrcLab.text = model.text;
    [self.tableView reloadData];

}
//- (NSArray *)lrcArr
//{
//    if (!_lrcArr) {
//        _lrcArr = [NSArray array];
//    }
//    return _lrcArr;
//}

@end
