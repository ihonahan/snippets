//
//  CentralAudio.h
//  wofa
//
//  Created by Ihonahan Buitrago on 17/10/13.
//  Copyright (c) 2013 ByYuto. All rights reserved.
//
//  Audio sources and files:
//  http://opengameart.org/content/wind-hit-time-morph
//  http://opengameart.org/content/9-sci-fi-computer-sounds-and-beeps
//  http://opengameart.org/content/4-sci-fi-menu-sounds
//  http://soundbible.com/suggest.php?q=soccer&x=10&y=12
//  http://opengameart.org/content/rpg-sound-pack
//  http://opengameart.org/content/tick-and-tock
//  http://oringz.com/ringtone/the-annoying-vuvuzela-sound/
//
//


#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CentralAudio : NSObject <AVAudioPlayerDelegate>

@property(strong) AVAudioSession *session;
@property(strong) AVAudioPlayer *bgMusicPlayer;
@property(strong) AVAudioPlayer *bgMusicGame;
@property(strong) AVAudioPlayer *fxPlayer1;
@property(strong) AVAudioPlayer *fxPlayer2;
@property(strong) AVAudioPlayer *fxPlayerSuccess;
@property(strong) AVAudioPlayer *fxPlayerFailure;
@property(strong) AVAudioPlayer *fxTickTack;


+ (CentralAudio *)sharedCentralAudio;

- (void)playBGMusic;
- (void)stopBGMusic;

- (void)playHitButton;
- (void)playHackSlashButton;

- (void)playSuccess;
- (void)playFailure;

- (void)playMenuOpen;
- (void)playMenuClose;

- (void)playZoneHover;
- (void)playZoneSelected;

- (void)playCoin1;

- (void)playTickTack;
- (void)stopTickTack;

@end
