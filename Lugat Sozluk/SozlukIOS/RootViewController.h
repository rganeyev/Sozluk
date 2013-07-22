//
//  RootViewController.h
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface RootViewController : UIViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray *indexArray;
    NSMutableArray *wordList;
    NSMutableArray *searchList;
    Word *selectedWord;
    IBOutlet UITableView *table;
    BOOL isSearchActive;
}

@end
