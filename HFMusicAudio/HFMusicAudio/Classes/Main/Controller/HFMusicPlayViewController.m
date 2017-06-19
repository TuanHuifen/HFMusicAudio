//
//  HFMusicPlayViewController.m
//  HFMusicAudio
//
//  Created by duanhuifen on 2017/6/15.
//  Copyright © 2017年 huifen. All rights reserved.
//

#import "HFMusicPlayViewController.h"
#import <Masonry.h>
#import "HFLrcScrollView.h"
#import "HFAudioTool.h"
#import "HFMusicTool.h"
#import "HFMusicModel.h"
#import <AVFoundation/AVFoundation.h>
#import "NSString+HFExtension.h"
#import "CALayer+HFExtension.h"
#import "HFLrcLab.h"

@interface HFMusicPlayViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *topToolView;
@property (weak, nonatomic) IBOutlet UILabel *MusicNameLab;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLab;
@property (weak, nonatomic) IBOutlet UIImageView *singerIconImageView;
@property (weak, nonatomic) IBOutlet HFLrcLab *currentLrcLab;
@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;
@property (weak, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet HFLrcScrollView *lrcScrollView;
@property (weak, nonatomic) IBOutlet UIButton *startOrPauseBtn;

@property (nonatomic,strong) AVAudioPlayer * player ;
@property (nonatomic,strong) NSTimer * progressTimer;
@property (nonatomic,strong) CADisplayLink * lrcTimer;

@end

@implementation HFMusicPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBlur];
    [self.progress setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];
    self.lrcScrollView.lrcLab = self.currentLrcLab;
    [self setUpLrcScrollView];
    [self startPlay];
    [self setUpIconUI];
}
//设置模糊背景
- (void)setUpBlur{
    UIToolbar * toolBar = [[UIToolbar alloc]init];
    [self.bgImageView addSubview:toolBar];
    toolBar.barStyle = UIBarStyleBlack;
    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.bgImageView);
    }];
}
//设置左滑时歌词的UIScrollView
- (void)setUpLrcScrollView{
    
    self.lrcScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    self.lrcScrollView.showsHorizontalScrollIndicator = NO;
    self.lrcScrollView.delegate = self;
    self.lrcScrollView.bounces = NO;
}
- (void)startPlay{
    self.currentLrcLab.text = nil;
    HFMusicModel * model = [HFMusicTool playingMusic];
    self.MusicNameLab.text = model.name;
    self.singerNameLab.text = model.singer;
    self.singerIconImageView.image = [UIImage imageNamed:model.icon];
    self.bgImageView.image = [UIImage imageNamed:model.icon];
    
    AVAudioPlayer * player = [HFAudioTool playMusicWithName:model.filename];
    self.startTimeLab.text = [NSString stringWithTime:player.currentTime];
    self.endTimeLab.text = [NSString stringWithTime:player.duration];
    self.player = player;
    
//    设置播放按钮的状态
    self.startOrPauseBtn.selected = self.player.isPlaying;
    self.lrcScrollView.lrcName = model.lrcname;
//    self.lrcScrollView.
    
    [self removeProgressTime];
    [self addProgressTimer];
    [self removeLrcTime];
    [self addLrcTimer];
    
    [self addIconAnimation];
}

//给icon UI 添加动画
- (void)addIconAnimation{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI * 2);
    animation.duration = 35;
    animation.repeatCount = NSIntegerMax;
    [self.singerIconImageView.layer addAnimation:animation forKey:nil];
}

//设置icon的UI
- (void)setUpIconUI{
    self.singerIconImageView.layer.cornerRadius = self.singerIconImageView.frame.size.width / 2;
    self.singerIconImageView.clipsToBounds = YES;
    self.singerIconImageView.layer.borderColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.6].CGColor;
    self.singerIconImageView.layer.borderWidth = 10;

}

#pragma mark ----定时器--------
- (void)addProgressTimer{
    [self updateMusicData];
    
//    self.progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateMusicData) userInfo:nil repeats:YES];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateMusicData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

- (void)removeProgressTime{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)addLrcTimer{
    self.lrcTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updataLrcData)];
    [self.lrcTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
- (void)removeLrcTime{
    [self.lrcTimer invalidate];
    self.lrcTimer = nil;
}
- (void)updataLrcData{
    self.lrcScrollView.currentTime = self.player.currentTime;
}

- (void)updateMusicData{
    self.startTimeLab.text = [NSString stringWithTime:self.player.currentTime];
    self.progress.value = self.player.currentTime / self.player.duration;
}
- (void)playMusicWithData:(HFMusicModel*)data{
    
    HFMusicModel * model = [HFMusicTool playingMusic];
    [HFAudioTool pauseMusicWithName:model.filename];
    
    [HFMusicTool setUpDefaultMusicWithData:data];
    [self startPlay];
}


#pragma mark -----action---------

- (IBAction)previewAction:(UIButton *)sender {
    HFMusicModel * model = [HFMusicTool previousMusic];
    [self playMusicWithData:model];
}
- (IBAction)nextAction:(UIButton *)sender {
    HFMusicModel * model = [HFMusicTool nextMusic];
    [self playMusicWithData:model];
}

- (IBAction)startOrPauseAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.player.isPlaying) {
        [self.player pause];
        [self removeProgressTime];
        [self.singerIconImageView.layer pauseLayer];
    }else{
        [self.player play];
        [self addProgressTimer];
        [self.singerIconImageView.layer resumeLayer];
    }
}

- (IBAction)progressDragAction:(UISlider *)sender {
    self.startTimeLab.text = [NSString stringWithTime:self.progress.value * self.player.duration];
}
- (IBAction)start:(UISlider *)sender {
    [self removeProgressTime];
}
- (IBAction)end:(UISlider *)sender {
    self.player.currentTime = self.progress.value * self.player.duration;
    [self addProgressTimer];
}

- (IBAction)clickProgressAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:sender.view];
    self.player.currentTime = point.x / self.progress.bounds.size.width * self.player.duration;
    [self updateMusicData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat alpha = 1 - point.x / scrollView.bounds.size.width;
    self.singerIconImageView.alpha = alpha;
    self.currentLrcLab.alpha = alpha;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
