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
    NSMutableArray *indexArray;
    NSMutableArray *wordList;
    NSMutableArray *searchList;
    Word *selectedWord;
    IBOutlet UITableView *table;
    IBOutlet UISearchDisplayController *searchDisplay;
    IBOutlet UISearchBar *searchBarText;
}

@property(nonatomic) BOOL isSearchActive;

//load words with its definitions from filename.txt
- (void)loadFromFile:(NSString *)fileName;

//initializes index arrays with proper letters in turkish/osman alphabet
- (void)initArray;

//filters content while searching
- (void)filterSearchContentForText:(NSString *)searchText;

- (void)searchText:(NSString *)searchText;
@end
