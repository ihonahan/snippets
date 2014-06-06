//
//  CentralAudio.m
//  wofa
//
//  Created by Ihonahan Buitrago on 17/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//

#import "CentralAudio.h"


@implementation CentralAudio

@synthesize session;
@synthesize bgMusicPlayer;
@synthesize bgMusicGame;
@synthesize fxPlayer1;
@synthesize fxPlayer2;
@synthesize fxPlayerSuccess;
@synthesize fxPlayerFailure;


+ (CentralAudio *)sharedCentralAudio
{
    static CentralAudio *_my_Central = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _my_Central = [[CentralAudio alloc] init];
    });
    
    return _my_Central;
}


- (id)init
{
    self = [super init];
    if (self) {
        // Audio session
        NSError *error = nil;
        self.session = [AVAudioSession sharedInstance];
        [self.session setCategory:AVAudioSessionCategoryPlayback withOptions:(AVAudioSessionCategoryOptionDefaultToSpeaker|AVAudioSessionCategoryOptionMixWithOthers|AVAudioSessionCategoryOptionAllowBluetooth) error:&error];
        
        if (!error) {
            [self.session setActive:YES error:nil];
        } else {
            NSLog(@"Unable to instantiate a valid audio session");
        }
        
        // BG Music Player
        NSString *bgSongPath = [[NSBundle mainBundle] pathForResource:@"intro_wofa" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:bgSongPath];
        self.bgMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error) {
            self.bgMusicPlayer.numberOfLoops = -1;
            self.bgMusicPlayer.volume = 0.2;
            self.bgMusicPlayer.delegate = self;
        } else {
            NSLog(@"Error playing intro track");
        }
        
        // BG Music Game
        // TODO: Get the BGM for gameplay

        // FX Success
        NSString *bgSuccessPath = [[NSBundle mainBundle] pathForResource:@"success" ofType:@"mp3"];
        url = [NSURL fileURLWithPath:bgSuccessPath];
        self.fxPlayerSuccess = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error) {
            self.fxPlayerSuccess.numberOfLoops = 0;
            self.fxPlayerSuccess.volume = 0.8;
            self.fxPlayerSuccess.delegate = self;
        } else {
            NSLog(@"Error creating FX Success");
        }

        // FX Failure
        // TODO: Get the FX Failure
        
        // FX TickTack
        NSString *ticktackPath = [[NSBundle mainBundle] pathForResource:@"ticktack" ofType:@"mp3"];
        url = [NSURL fileURLWithPath:ticktackPath];
        self.fxTickTack = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (!error) {
            self.fxTickTack.numberOfLoops = -1;
            self.fxTickTack.volume = 0.9;
            self.fxTickTack.delegate = self;
        } else {
            NSLog(@"Error creating FX Tick Tack Clock");
        }

    }
    
    return self;
}

- (void)playBGMusic
{
    [self.bgMusicPlayer prepareToPlay];
    [self.bgMusicPlayer play];
}

- (void)stopBGMusic
{
    [self.bgMusicPlayer stop];
}

- (void)playHitButton
{
    if (self.fxPlayer1) {
        [self.fxPlayer1 stop];
        self.fxPlayer1 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"hitButton" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer1.numberOfLoops = 0;
        self.fxPlayer1.volume = 0.9;
        [self.fxPlayer1 prepareToPlay];
        [self.fxPlayer1 play];
    }else {
        NSLog(@"Error playing hit button FX");
    }
}

- (void)playHackSlashButton
{
    if (self.fxPlayer1) {
        [self.fxPlayer1 stop];
        self.fxPlayer1 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"hackslash" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer1.numberOfLoops = 0;
        self.fxPlayer1.volume = 0.9;
        [self.fxPlayer1 prepareToPlay];
        [self.fxPlayer1 play];
    }else {
        NSLog(@"Error playing hit button FX");
    }
}


- (void)playSuccess
{
    [self.fxPlayerSuccess prepareToPlay];
    [self.fxPlayerSuccess play];
}

- (void)playFailure
{
    
}


- (void)playMenuOpen
{
    if (self.fxPlayer2) {
        [self.fxPlayer2 stop];
        self.fxPlayer2 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"menu_open" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer2.numberOfLoops = 0;
        self.fxPlayer2.volume = 0.9;
        [self.fxPlayer2 prepareToPlay];
        [self.fxPlayer2 play];
    }else {
        NSLog(@"Error playing Menu Open FX");
    }
}



- (void)playMenuClose
{
    if (self.fxPlayer2) {
        [self.fxPlayer2 stop];
        self.fxPlayer2 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"menu_close" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer2.numberOfLoops = 0;
        self.fxPlayer2.volume = 0.9;
        [self.fxPlayer2 prepareToPlay];
        [self.fxPlayer2 play];
    }else {
        NSLog(@"Error playing Menu Close FX");
    }
}


- (void)playZoneHover
{
    if (self.fxPlayer2) {
        [self.fxPlayer2 stop];
        self.fxPlayer2 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"itempick1" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer2.numberOfLoops = 0;
        self.fxPlayer2.volume = 0.9;
        [self.fxPlayer2 prepareToPlay];
        [self.fxPlayer2 play];
    }else {
        NSLog(@"Error playing Zone Hover FX");
    }
}


- (void)playZoneSelected
{
    if (self.fxPlayer1) {
        [self.fxPlayer1 stop];
        self.fxPlayer1 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"zoneSelected" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer1.numberOfLoops = 0;
        self.fxPlayer1.volume = 0.9;
        [self.fxPlayer1 prepareToPlay];
        [self.fxPlayer1 play];
    }else {
        NSLog(@"Error playing Zone Selected FX");
    }
}


- (void)playCoin1
{
    if (self.fxPlayer1) {
        [self.fxPlayer1 stop];
        self.fxPlayer1 = nil;
    }
    
    NSString *hitButtonPath = [[NSBundle mainBundle] pathForResource:@"coin1" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:hitButtonPath];
    NSError *error = nil;
    self.fxPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!error) {
        self.fxPlayer1.numberOfLoops = 0;
        self.fxPlayer1.volume = 0.9;
        [self.fxPlayer1 prepareToPlay];
        [self.fxPlayer1 play];
    }else {
        NSLog(@"Error playing Coin 1 FX");
    }
}


- (void)playTickTack
{
    [self.fxTickTack prepareToPlay];
    [self.fxTickTack play];
}

- (void)stopTickTack
{
    [self.fxTickTack stop];
}



#pragma mark - AVAudioPlayerDelegate methods



@end
