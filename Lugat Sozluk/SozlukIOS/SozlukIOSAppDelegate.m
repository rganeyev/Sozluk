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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    lastWord = [defaults stringForKey:LAST_WORD];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    if ([pasteboard containsPasteboardTypes:UIPasteboardTypeListString] && pasteboard.strings.count == 1) {
        NSString *string = pasteboard.string;
        NSRange range = [string rangeOfString:@" "];
        if (range.location != NSNotFound) {
            string = [string substringToIndex:range.location];
        }
        
        if (![lastWord isEqualToString:string]) {
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popToRootViewControllerAnimated:NO];
            }
            [defaults setValue:string forKey:LAST_WORD];
            RootViewController *rootViewController = (RootViewController *) self.navigationController.topViewController;
            [rootViewController searchText:string];
        }
    }
}


@end
