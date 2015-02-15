//
//  SongDetailViewController.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "SongDetailViewController.h"


@interface SongDetailViewController ()

@end

@implementation SongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.song != nil) {
        self.titleLabel.text = self.song.title;
        self.artistLabel.text = self.song.artist;
        self.albumLabel.text = self.song.album;
        self.image.image = [UIImage imageNamed:self.song.image];
        self.audioPlayer = [self _audioPlayerWithSong:self.song];
        [self.audioPlayer play];
    }
}

/*!
 * Return new audio player for given song
 */
-(AVAudioPlayer *)_audioPlayerWithSong:(Song *)song
{
    // create audio player
    NSError * error;
    
    NSURL *url = [Song urlFromFilepath:song.filepath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    // log error message if any
    if (self.audioPlayer == nil) {
        NSLog(@"Audio player Error: %@", error);
    }
    
    return self.audioPlayer;
}

- (IBAction)pressPlay:(id)sender {
    if ([self.audioPlayer isPlaying]) {
        [self _pause];
    } else {
        [self _play:self.song];
    }
}

- (IBAction)swipedRight:(id)sender {
    NSLog(@"user swiped right");
}

- (void)_play:(Song *)song
{
    [self.audioPlayer play];
    [self _togglePlayButton];
}

- (void)_pause
{
    [self.audioPlayer pause];
    [self _togglePlayButton];
}

-(void)_togglePlayButton
{
    [self.pauseLabel setText:([self.audioPlayer isPlaying] ? @"" : @"Pause")];
}
@end
