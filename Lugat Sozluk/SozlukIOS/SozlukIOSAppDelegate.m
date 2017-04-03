//
//  SozlukIOSAppDelegate.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import "SozlukIOSAppDelegate.h"
#import "RootViewController.h"
#import "Flurry.h"

@implementation SozlukIOSAppDelegate

NSString *const LAST_WORD = @"lastWord";

@synthesize window = _window;

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Flurry startSession:@"QHPKYJH9JN4JSGPM2VW6"];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
