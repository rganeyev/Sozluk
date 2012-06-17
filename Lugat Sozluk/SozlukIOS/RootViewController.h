//
//  RootViewController.h
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *indexArray;
    NSMutableArray *wordList;
    NSMutableArray *searchList;
    IBOutlet UITableView *table;
}

@property (nonatomic)BOOL isSearchActive;

//load words with its definitions from filename.txt
- (void)loadFromFile:(NSString*)fileName;

//initializes index arrays with proper letters in turkish/osman alphabet
- (void)initArray;

//Converts turkish letter to latin analog
- (unichar) convertSymbol:(unichar)ch;
//compares turkish symbols. Turkish diactric letters are supposed the same as latin(e.g. Ÿ = u)
- (NSComparisonResult)compareTurkishSymbol:(unichar)ch With:(unichar)another;
                                                        
//compares words in range (0, word.length)
//return NSOrderSame, if another = word + some string
//turkish 'diactric' letters are supposed the same as latin letters(e.g. Ÿ = u)
- (NSComparisonResult)compareTurkish:(NSString*)word With:(NSString*)another;

//filters content while searching
- (void)filterSearchContentForText:(NSString*)searchText;
@end
