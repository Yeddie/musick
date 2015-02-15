//
//  Song.h
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CoreDataStack.h"

@interface Song : NSManagedObject

@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *artist;
@property (retain, nonatomic) NSString *album;
@property (retain, nonatomic) NSString *duration;
@property (retain, nonatomic) NSString *year;
@property (retain, nonatomic) NSString *filepath;
@property (retain, nonatomic) NSString *image;


+ (void) loadAll;
+ (void) deleteAll;
+ (void) insertSongWithTitle:(NSString *) title andArtist:(NSString *) artist
                    andAlbum:(NSString *) album andDuration:(NSString *) duration
                     andYear:(NSString *) year andFilepath:(NSString *) filepath
                    andImage:(NSString *) image;
+ (NSURL *) urlFromFilepath:(NSString *) filepath;

@end
