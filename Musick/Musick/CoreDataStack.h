//
//  CoreDataStack.h
//  Musick
//
//  Created by Eddie Groberski on 1/31/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype) defaultStack;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
