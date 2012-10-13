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


@synthesize window = _window;

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSLog(@"%@", lastWord);
    if ([pasteboard containsPasteboardTypes:UIPasteboardTypeListString] && pasteboard.strings.count == 1 && ![lastWord isEqualToString:pasteboard.string]) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        lastWord = pasteboard.string;

        RootViewController *rootViewController = (RootViewController *) self.navigationController.topViewController;
        [rootViewController searchText:pasteboard.string];
    }
}


@end
