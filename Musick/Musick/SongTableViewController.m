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

@interface SongTableViewController () <NSFetchedResultsControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) NSUInteger songCount;

@end

@implementation SongTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load custom SongTableViewCell
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:@"songCellReuseId"];

    [self.fetchedResultsController performFetch:nil];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self hideApplicationBars: NO];
}


/*!
 * Hide or show tab bar and navigation bar
 */
- (void)hideApplicationBars:(BOOL)hidden {
    //Hide or show tab bar
    self.tabBarController.tabBar.hidden = hidden;
    //Hide or show navigation bar
    self.navigationController.navigationBarHidden = hidden;
}


/*!
 * Hide status bar
 */
-(BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark - NSFetchRequest


/*!
 * Create fetchRequest for Songs
 */
- (NSFetchRequest *)songListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO]];
    return fetchRequest;
}


/*!
 * Create fetchedResultsController of Songs to display them
 */
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self songListFetchRequest];
    
    //Get count of total Songs
    NSError *error;
    self.songCount = [coreDataStack.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error getting count: %@", error);
    }
    
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
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Create pageViewController
    [self initPageViewController:indexPath];
    //Deselect row since viewDidDisappear does get triggered
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - UIPageViewControllerDataSource


/*!
 * Create SongPageViewController and display SongDetailViewController for picked Song
 */
- (void) initPageViewController:(NSIndexPath *)indexPath {
    UIPageViewController *pageController = [self.storyboard instantiateViewControllerWithIdentifier: @"SongPageController"];
    pageController.dataSource = self;

    if (self.songCount) {
        //Create 1 viewController for picked Song
        NSArray *startingViewControllers = @[[self songDetailViewControllerForIndex: indexPath]];
        [pageController setViewControllers: startingViewControllers
                                 direction: UIPageViewControllerNavigationDirectionForward
                                  animated: NO
                                completion: nil];
    }
    
    self.pageViewController = pageController;
    
    [self hideApplicationBars: YES];
    [self addChildViewController: self.pageViewController];
    [self.view addSubview: self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController: self];
}


/*!
 * Activates when user swipes left - create SongDetailViewController for previous song
 */
- (UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerBeforeViewController:(UIViewController *) viewController
{
    SongDetailViewController *songDetailViewController = (SongDetailViewController *) viewController;
    
    NSUInteger songIndex = songDetailViewController.songIndex;
    
    if (songIndex > 0)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:songIndex - 1 inSection:0];
        return [self songDetailViewControllerForIndex:path];
    }
    
    return nil;
}


/*!
 * Activates when user swipes right - create SongDetailViewController for next song
 */
- (UIViewController *) pageViewController: (UIPageViewController *) pageViewController viewControllerAfterViewController:(UIViewController *) viewController
{
    SongDetailViewController *songDetailViewController = (SongDetailViewController *) viewController;
    
    NSUInteger songIndex = songDetailViewController.songIndex;
    
    if (songIndex + 1 < self.songCount)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:songIndex + 1 inSection:0];
        return [self songDetailViewControllerForIndex:path];
    }
    
    return nil;
}

 
/*!
 * Create SongDetailViewController and set Song property
 */
- (SongDetailViewController *) songDetailViewControllerForIndex:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.songCount){
        SongDetailViewController *songDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"SongDetailViewController"];
        songDetailViewController.song = [self.fetchedResultsController objectAtIndexPath:indexPath];
        songDetailViewController.songIndex = indexPath.row;
        songDetailViewController.songTableViewController = self;
        return songDetailViewController;
    }
    
    return nil;
}


@end
