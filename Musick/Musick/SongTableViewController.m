//
//  SongsTableViewController.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "SongTableViewController.h"
#import "CoreDataStack.h"
#import "Song.h"
#import "SongTableViewCell.h"
#import "SongDetailViewController.h"

@interface SongTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation SongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:@"songCellReuseId"];
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark - NSFetchRequest

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO]];
    return fetchRequest;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]
                                 initWithFetchRequest:fetchRequest
                                 managedObjectContext:coreDataStack.managedObjectContext
                                 sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCellReuseId" forIndexPath:indexPath];

    Song *song = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = song.title;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = song.artist;
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showSongDetail" sender:cell];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSongDetail"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        SongDetailViewController *songDetailViewController = (SongDetailViewController *) segue.destinationViewController;
        songDetailViewController.song = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
}


@end
