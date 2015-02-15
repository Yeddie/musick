//
//  SongDetailViewController.h
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"

@interface SongDetailViewController : UIViewController

@property (strong, nonatomic) Song *song;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *pauseLabel;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (void)_play:(Song *)song;
- (void)_pause;
- (void)_togglePlayButton;
- (IBAction)pressPlay:(id)sender;
- (IBAction)swipedRight:(id)sender;

@end
