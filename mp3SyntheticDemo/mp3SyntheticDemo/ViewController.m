//
//  ViewController.m
//  mp3SyntheticDemo
//
//  Created by 李文举 on 2018/3/13.
//  Copyright © 2018年 iOS. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"开始合成");
    
    //音频文件路径
    NSString *mp3Path1 = [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"mp3"];
    NSString *mp3Path2 = [[NSBundle mainBundle] pathForResource:@"Paradise" ofType:@"mp3"];
    NSString *mp3Path3 = [[NSBundle mainBundle] pathForResource:@"Shining" ofType:@"mp3"];
    NSString *mp3Path4 = [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"mp3"];
    NSString *mp3Path5 = [[NSBundle mainBundle] pathForResource:@"Paradise" ofType:@"mp3"];
    NSString *mp3Path6 = [[NSBundle mainBundle] pathForResource:@"Shining" ofType:@"mp3"];
    NSString *mp3Path7 = [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"mp3"];
    NSString *mp3Path8 = [[NSBundle mainBundle] pathForResource:@"Paradise" ofType:@"mp3"];
    NSString *mp3Path9 = [[NSBundle mainBundle] pathForResource:@"Shining" ofType:@"mp3"];
    //音频数据
    NSData *sound1Data = [[NSData alloc] initWithContentsOfFile: mp3Path1];
    NSData *sound2Data = [[NSData alloc] initWithContentsOfFile: mp3Path2];
    NSData *sound3Data = [[NSData alloc] initWithContentsOfFile: mp3Path3];
    NSData *sound4Data = [[NSData alloc] initWithContentsOfFile: mp3Path4];
    NSData *sound5Data = [[NSData alloc] initWithContentsOfFile: mp3Path5];
    NSData *sound6Data = [[NSData alloc] initWithContentsOfFile: mp3Path6];
    NSData *sound7Data = [[NSData alloc] initWithContentsOfFile: mp3Path7];
    NSData *sound8Data = [[NSData alloc] initWithContentsOfFile: mp3Path8];
    NSData *sound9Data = [[NSData alloc] initWithContentsOfFile: mp3Path9];
    
    //合并音频
    NSMutableData *sounds = [NSMutableData alloc];
    [sounds appendData:sound1Data];
    [sounds appendData:sound2Data];
    [sounds appendData:sound3Data];
    [sounds appendData:sound4Data];
    [sounds appendData:sound5Data];
    [sounds appendData:sound6Data];
    [sounds appendData:sound7Data];
    [sounds appendData:sound8Data];
    [sounds appendData:sound9Data];
    //保存音频
    
    NSLog(@"data length:%lu", (unsigned long)[sounds length]);
    
    [sounds writeToFile:[self filePathWithName:@"tmp.mp3"] atomically:YES];
    
    NSLog(@"合成结束");
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self filePathWithName:@"tmp.mp3"]] error:nil];
    self.player.delegate = self;
    [self.player prepareToPlay];
    [self.player play];
    
//    NSString *auidoPath1 = [[NSBundle mainBundle] pathForResource:@"Intro" ofType:@"mp3"];
//    NSString *audioPath2 = [[NSBundle mainBundle] pathForResource:@"Paradise" ofType:@"mp3"];
//    NSString *audioPath3 = [[NSBundle mainBundle] pathForResource:@"Shining" ofType:@"mp3"];
//    AVURLAsset *audioAsset1 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:auidoPath1]];
//    AVURLAsset *audioAsset2 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:audioPath2]];
//    AVURLAsset *audioAsset3 = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:audioPath3]];
//
//    AVMutableComposition *composition = [AVMutableComposition composition];    // 音频轨道
//    AVMutableCompositionTrack *audioTrack1 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
//    AVMutableCompositionTrack *audioTrack2 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
//    AVMutableCompositionTrack *audioTrack3 = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:0];
//    // 音频素材轨道
//    AVAssetTrack *audioAssetTrack1 = [[audioAsset1 tracksWithMediaType:AVMediaTypeAudio] firstObject];
//    AVAssetTrack *audioAssetTrack2 = [[audioAsset2 tracksWithMediaType:AVMediaTypeAudio] firstObject];
//    AVAssetTrack *audioAssetTrack3 = [[audioAsset3 tracksWithMediaType:AVMediaTypeAudio] firstObject];
//
//    [audioTrack1 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset1.duration) ofTrack:audioAssetTrack1 atTime:kCMTimeZero error:nil];
//    [audioTrack2 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset2.duration) ofTrack:audioAssetTrack2 atTime:kCMTimeZero error:nil];
//    [audioTrack3 insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset3.duration) ofTrack:audioAssetTrack3 atTime:kCMTimeZero error:nil];
//
//    // 合并后的文件导出 - 音频文件目前只找到合成m4a类型的
//    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetAppleM4A];
//    NSString *outPutFilePath = [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"xindong.m4a"];
//    session.outputURL = [NSURL fileURLWithPath:outPutFilePath];
//    session.outputFileType = AVFileTypeAppleM4A;
//    [session exportAsynchronouslyWithCompletionHandler:^{        NSLog(@"合并完成----%@", outPutFilePath);
//        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:outPutFilePath] error:nil];
//        [_player play];
//    }];
    
}

- (NSString *)filePathWithName:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:filename];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
//    MPMusicPlayerController *ipodPlayer = [MPMusicPlayerController iPodMusicPlayer];
//    if ([ipodPlayer playbackState] == MPMusicPlaybackStateInterrupted) {
//        [ipodPlayer play];
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
