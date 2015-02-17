//
//  AppDelegate.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "AppDelegate.h"
#import "Song.h"
#import "CoreDataStack.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Dev functions to test data loading - REMOVE!!!!
    //[Song loadAll];
    //[Song deleteAll];
    
    //Load defualt songs
    [self checkDefaultSongs];
    
    //Set appearance of the application
    [self setGlobalAppearance];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

- (NSFetchRequest *)entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO]];
    return fetchRequest;
}

/*!
 * Check Song entity, insert 5 default songs if empty
 */
- (void)checkDefaultSongs {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    NSError *error;
    NSUInteger songCount = [coreDataStack.managedObjectContext countForFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Error getting song count: %@", error);
    } else if (songCount == 0) {
        [Song loadAll];
    }
}

/*!
 * Configure appearance of the application
 */
- (void)setGlobalAppearance {
    //Set tab bar tint color to white
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    //Set tab bar font style and color
    [UITabBarItem.appearance setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16]
                                                       } forState:UIControlStateNormal];
    
    //Set navigation bar font style and color
    NSDictionary *options = @{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25],
                              NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:options];
}

@end
