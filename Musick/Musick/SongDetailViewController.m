//
//  SongDetailViewController.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "SongDetailViewController.h"
#import "SongPageViewController.h"


@interface SongDetailViewController ()

@end

@implementation SongDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Set lables and image
    if (self.song) {
        self.titleLabel.text = self.song.title;
        self.artistLabel.text = self.song.artist;
        self.albumLabel.text = self.song.album;
        self.image.image = [UIImage imageNamed:self.song.image];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.song) {
        //Create audio player and then play song
        self.audioPlayer = [self _audioPlayerWithSong:self.song];
        [self.audioPlayer play];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //Remove audio player when we have moved to next song
    self.audioPlayer = nil;
}


#pragma mark - AVAudioPlayer


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


/*!
 * Play Song
 */
- (void)play:(Song *)song
{
    [self.audioPlayer play];
    [self togglePauseImage];
}


/*!
 * Pause Song
 */
- (void)pause
{
    [self.audioPlayer pause];
    [self togglePauseImage];
}


/*!
 * Show or clear pause image
 */
-(void)togglePauseImage
{
    if ([self.audioPlayer isPlaying]) {
        self.pauseImage.image = nil;
        self.pauseImage.backgroundColor = [UIColor clearColor];
    } else {
        self.pauseImage.image = [UIImage imageNamed:@"pause"];
        self.pauseImage.backgroundColor = [UIColor colorWithRed:170.0 green:170.0 blue:170.0 alpha:0.45];
    }
}


#pragma mark - IBActions


/*!
 * Gesture action to play Song
 */
- (IBAction)pressPlay:(id)sender {
    if ([self.audioPlayer isPlaying]) {
        [self pause];
    } else {
        [self play:self.song];
    }
}


/*!
 * Remove pageViewController and return to SongTableViewController
 */
- (IBAction)hideSong:(id)sender {
    [self dismissSelf];
}


- (void)dismissSelf {
    [self.songTableViewController.pageViewController willMoveToParentViewController:nil];
    [self.songTableViewController.pageViewController.view removeFromSuperview];
    [self.songTableViewController.pageViewController removeFromParentViewController];
    [self.songTableViewController viewDidAppear:YES];
}

@end
