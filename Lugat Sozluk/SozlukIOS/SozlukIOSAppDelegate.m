//
//  SozlukIOSAppDelegate.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import "SozlukIOSAppDelegate.h"
#import "RootViewController.h"

@implementation SozlukIOSAppDelegate

NSString *const LAST_WORD = @"lastWord";

@synthesize window = _window;

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
