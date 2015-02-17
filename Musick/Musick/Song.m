//
//  Song.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "Song.h"
#import "CHCSVParser.h"

int const SONG_TITLE_INDEX = 0;
int const SONG_ARTIST_INDEX = 1;
int const SONG_ALBUM_INDEX = 2;
int const SONG_DURATION_INDEX = 3;
int const SONG_YEAR_INDEX = 4;
int const SONG_FILEPATH_INDEX = 5;
int const SONG_IMAGE_INDEX = 6;

@implementation Song

@dynamic title;
@dynamic artist;
@dynamic album;
@dynamic duration;
@dynamic year;
@dynamic filepath;
@dynamic image;


#pragma mark - init


/*
Create Song NSManagedObject object and save to Song Entity
*/
+ (void) initSongWithTitle:(NSString *) title andArtist:(NSString *) artist
                    andAlbum:(NSString *) album andDuration:(NSString *) duration
                     andYear:(NSString *) year andFilepath:(NSString *) filepath
                    andImage:(NSString *) image {
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    Song *song = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    song.title = title;
    song.artist = artist;
    song.album = album;
    song.duration = duration;
    song.year = year;
    song.filepath = filepath;
    song.image = image;

    [coreDataStack saveContext];
}


#pragma mark - Song loading


/*!
 * Parse CSV file and insert all default Songs into Song Entity
 */
+(void)loadAll {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *pathUrl = [bundle URLForResource:@"songs" withExtension:@"csv"];
    
    //CSV file structure = title;artist;album;duration;year;filePath;image;
    NSArray * csv = [NSArray arrayWithContentsOfDelimitedURL:pathUrl delimiter:';'];
    if (csv == nil) {
        NSLog(@"CSV file is empty");
    }
    
    //Loop through csv file and insert songs into Core Data
    for (NSArray *songRow in csv) {
        NSString *title    = songRow[SONG_TITLE_INDEX];
        NSString *artist   = songRow[SONG_ARTIST_INDEX];
        NSString *album    = songRow[SONG_ALBUM_INDEX];
        NSString *duration = songRow[SONG_DURATION_INDEX];
        NSString *year     = songRow[SONG_YEAR_INDEX];
        NSString *filepath = songRow[SONG_FILEPATH_INDEX];
        NSString *image    = songRow[SONG_IMAGE_INDEX];
        
        //Create Song and insert into Song Entity
        [self initSongWithTitle:title andArtist:artist
                       andAlbum:album andDuration:duration
                        andYear:year andFilepath:filepath
                       andImage:image];
    }
}

/*!
 * Retrieve all Songs and delete them from the Song Entity
 */
+ (void)deleteAll {
    NSFetchRequest *allSongs = [[NSFetchRequest alloc] init];
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    [allSongs setEntity:[NSEntityDescription entityForName:@"Song" inManagedObjectContext:[coreDataStack managedObjectContext]]];
    [allSongs setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *songs = [coreDataStack.managedObjectContext executeFetchRequest:allSongs error:&error];
    
    //error handling goes here
    for (NSManagedObject *song in songs) {
        [[coreDataStack managedObjectContext] deleteObject:song];
    }
    
    [coreDataStack saveContext];
}


#pragma mark - Helper functions


/*!
 * Create URL for Song .mp3 file
 */
+ (NSURL *) urlFromFilepath:(NSString *) filepath;
{
    //Remove .mp3 from track name
    NSString * filename = [filepath stringByReplacingOccurrencesOfString:@".mp3" withString:@""];
    
    NSBundle * bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:filename withExtension:@"mp3"];

    return url;
}

@end
