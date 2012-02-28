//
//  SozlukAppDelegate.h
//  Sozluk
//
//  Created by Rustam Ganeyev on 11/2/11.
//  Copyright 2011 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SozlukAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UIView *view;

@end
