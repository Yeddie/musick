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
#import "SongTableViewController.h"

@interface SongDetailViewController : UIViewController

//Song
@property (strong, nonatomic) Song *song;
//Music player
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) NSUInteger songIndex;
@property (strong, nonatomic) SongTableViewController *songTableViewController;

//Outlets
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *pauseImage;

- (void)play:(Song *)song;
- (void)pause;
- (void)togglePauseImage;
- (IBAction)pressPlay:(id)sender;
- (IBAction)hideSong:(id)sender;


@end
