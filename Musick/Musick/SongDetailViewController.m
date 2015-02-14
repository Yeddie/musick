//
//  SongDetailViewController.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "SongDetailViewController.h"
#import "Song.h"

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
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
