//
//  RootViewController.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@implementation RootViewController

@synthesize isSearchActive;

static NSString *cellID = @"cellID";
static NSString *segueID = @"detailSegue";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFromFile:@"copy"];
    isSearchActive = NO;
    searchList = [[NSMutableArray alloc] init];
    [table reloadData];
}

#pragma mark -
#pragma mark SearchDisplayDelegate


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterSearchContentForText:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return NO;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    isSearchActive = YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    isSearchActive = NO;
}

#pragma mark TableViewDelegate 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearchActive) {
        return 1;
    } else {
        return [wordList count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearchActive) {
        return [searchList count];
    } else {
        NSMutableArray *arr = [wordList objectAtIndex:section];
        return [arr count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

    Word *word = nil;
    if (isSearchActive) {
        word = [searchList objectAtIndex:indexPath.row];
    } else {
        NSMutableArray *arr = [wordList objectAtIndex:indexPath.section];
        word = [arr objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = word.all;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isSearchActive) {
        selectedWord = [searchList objectAtIndex:indexPath.row];
    } else {
        NSMutableArray *arr = [wordList objectAtIndex:indexPath.section];
        selectedWord = [arr objectAtIndex:indexPath.row];
    }
    [self performSegueWithIdentifier:segueID sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:segueID]) {
        DetailViewController *controller = segue.destinationViewController;
        controller.word = selectedWord;
    }
}

#pragma mark RootViewController Methods

- (void)loadFromFile:(NSString *)fileName {
    [self initArray];

    NSString *fileRoot = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
    NSArray *allWords = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    wordList = [[NSMutableArray alloc] init];
    NSInteger cur = 0;
    for (NSString *letter in indexArray) {
        //NSLog(@"letter %@ %d", letter, cur);
        NSMutableArray *letterArray = [[NSMutableArray alloc] init];
        while (cur < [allWords count]) {
            NSString *currentWord = [allWords objectAtIndex:cur];
            NSString *str = [currentWord substringWithRange:NSMakeRange(0, 1)];
            if ([str compare:@"î" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                str = @"i";
            } else if ([str compare:@"â" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                str = @"a";
            } else if ([str compare:@"û" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                str = @"u";
            }
            if ([str compare:letter options:NSCaseInsensitiveSearch] != NSOrderedSame) {
                break;
            }

            [letterArray addObject:[Word wordWith:currentWord]];
            ++cur;
        }
        [wordList addObject:letterArray];
    }
}

- (void)initArray {
    indexArray = @[@"a", @"b", @"c", @"ç", @"d", @"e", @"f", @"g", @"h", @"ı", @"i", @"j", @"k", @"l", @"m", @"n", @"o",
            @"ö", @"p", @"r", @"s", @"ş", @"t", @"u", @"ü", @"v", @"y", @"z"];
    //@"ı": 9
    //@"ş": 21
}


- (void)filterSearchContentForText:(NSString *)searchText {
    searchText = [searchText lowercaseString];
    [searchList removeAllObjects];
    if (searchText == nil || [searchText length] == 0) {
        return;
    }

    for (NSMutableArray *arr in wordList) {
        Word *word = [arr objectAtIndex:0];
        if ([Word compareTurkishSymbol:[word.word characterAtIndex:0] With:[searchText characterAtIndex:0]] != NSOrderedSame) {
            continue;
        }

        NSUInteger left = 0;
        NSUInteger right = [arr count];
        while (left < right - 1) {
            NSUInteger c = (left + right) / 2;
            NSComparisonResult result = [word compareWith:[arr objectAtIndex:c]];
            if (result == NSOrderedDescending) {
                left = c;
            } else {
                right = c;
            }
        }
        while (left < [arr count]) {
            NSComparisonResult result = [word compareWith:[arr objectAtIndex:left]];
            if (result == NSOrderedSame) {
                [searchList addObject:[arr objectAtIndex:left]];
            }
            ++left;
        }
    }
}

- (void)searchText:(NSString *)searchText {
    isSearchActive = YES;
    [searchDisplay.searchBar becomeFirstResponder];
    [searchDisplay.searchBar setText:searchText];
}


#pragma mark indexing
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    if (isSearchActive) {
        return nil;
    }
    return indexArray;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {

    if (isSearchActive) {
        return -1;
    }
    return index;
}


@end
