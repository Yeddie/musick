//
//  SongPageViewController.h
//  Musick
//
//  Created by Eddie Groberski on 2/15/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"

@interface SongPageViewController : UIPageViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
