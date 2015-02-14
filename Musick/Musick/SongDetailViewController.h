//
//  SongDetailViewController.h
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Song;

@interface SongDetailViewController : UIViewController

@property (strong, nonatomic) Song *song;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
