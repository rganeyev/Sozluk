//
//  RootViewController.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/6/12.
//  Copyright 2012 HOME. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

//TODO: refactor this
@implementation RootViewController

@synthesize isSearchActive;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFromFile:@"dict"];
    isSearchActive = NO;
    searchList = [[NSMutableArray alloc] init];
    self.title = @"Words";
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
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.opaque = NO;

    NSString *word = nil;
    if (self.isSearchActive) {
        if (searchList.count < indexPath.row) {
            return cell;
        }
        word = [searchList objectAtIndex:indexPath.row];
    } else {
        NSMutableArray *arr = [wordList objectAtIndex:indexPath.section];
        word = [arr objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = word;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *viewXib = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"DetailViewController-Pad" : @"DetailViewController";
    DetailViewController *view = [[DetailViewController alloc] initWithNibName:viewXib bundle:nil];
    if (self.isSearchActive) {
        view.wordDefinition = [searchList objectAtIndex:indexPath.row];
    } else {
        NSMutableArray *arr = [wordList objectAtIndex:indexPath.section];
        view.wordDefinition = [arr objectAtIndex:indexPath.row];
    }

    view.title = @"Definition";
    [self.navigationController pushViewController:view animated:YES];
}


#pragma mark RootViewController Methods

- (void)loadFromFile:(NSString *)fileName {
    [self initArray];

    NSString *fileRoot = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString *fileContents = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:nil];
    NSMutableArray *allWords;
    allWords = [NSMutableArray arrayWithArray:[fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]];

    wordList = [[NSMutableArray alloc] init];
    NSInteger cur = 0;
    for (NSString *letter in indexArray) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        while (cur < [allWords count]) {
            NSString *str = [[allWords objectAtIndex:cur] substringWithRange:NSMakeRange(0, 1)];
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

            [arr addObject:[allWords objectAtIndex:cur]];
            ++cur;
        }
        [wordList addObject:arr];
    }
}

- (void)initArray {
    indexArray = [[NSMutableArray alloc] init];
    [indexArray addObject:@"a"];
    [indexArray addObject:@"b"];
    [indexArray addObject:@"c"];
    [indexArray addObject:@"ç"];
    [indexArray addObject:@"d"];
    [indexArray addObject:@"e"];
    [indexArray addObject:@"f"];
    [indexArray addObject:@"g"];
    [indexArray addObject:@"h"];
    [indexArray addObject:@"ı"];//9
    [indexArray addObject:@"i"];
    [indexArray addObject:@"j"];
    [indexArray addObject:@"k"];
    [indexArray addObject:@"l"];
    [indexArray addObject:@"m"];
    [indexArray addObject:@"n"];
    [indexArray addObject:@"o"];
    [indexArray addObject:@"ö"];
    [indexArray addObject:@"p"];
    [indexArray addObject:@"r"];
    [indexArray addObject:@"s"];
    [indexArray addObject:@"ş"];//21
    [indexArray addObject:@"t"];
    [indexArray addObject:@"u"];
    [indexArray addObject:@"ü"];
    [indexArray addObject:@"v"];
    [indexArray addObject:@"y"];
    [indexArray addObject:@"z"];
}

- (unichar)convertSymbol:(unichar)ch {
    switch (ch) {
        case 226:
            ch = 'a';
            break;
        case 305:
        case 238:
            ch = 'i';
            break;
        case 252:
        case 251:
            ch = 'u';
            break;
        case 246:
        case 244:
            ch = 'o';
            break;
        case 231:
            ch = 'c';
            break;
        case 350:
        case 351:
            ch = 's';
            break;
        case 287:
        case 290:
        case 291:
            ch = 'g';
            break;
        default:
            break;
    }
    return ch;
}

- (NSComparisonResult)compareTurkishSymbol:(unichar)ch With:(unichar)another {
    return ([self convertSymbol:ch] - [self convertSymbol:another]);
}

- (NSComparisonResult)compareTurkish:(NSString *)word With:(NSString *)another {
    NSString *tmp = [[NSString alloc] initWithString:[another lowercaseString]];
    NSUInteger len = [word length];
    for (NSUInteger i = 0; i < len; ++i) {
        NSComparisonResult res = [self compareTurkishSymbol:[word characterAtIndex:i] With:[tmp characterAtIndex:i]];
        if (res != NSOrderedSame) {
            return res;
        }
    }
    return NSOrderedSame;
}

- (void)filterSearchContentForText:(NSString *)searchText {
    searchText = [searchText lowercaseString];
    [searchList removeAllObjects];
    if (searchText == nil || [searchText length] == 0) {
        return;
    }


    for (NSMutableArray *arr in wordList) {
        NSString *str = [arr objectAtIndex:0];
        if ([self compareTurkishSymbol:[str characterAtIndex:0] With:[searchText characterAtIndex:0]] != NSOrderedSame) {
            continue;
        }

        NSUInteger left = 0;
        NSUInteger right = [arr count];
        while (left < right - 1) {
            NSUInteger c = (left + right) / 2;
            NSComparisonResult result = [self compareTurkish:searchText With:[arr objectAtIndex:c]];
            if (result == NSOrderedDescending) {
                left = c;
            } else {
                right = c;
            }
        }
        while (left < [arr count]) {
            NSComparisonResult result = [self compareTurkish:searchText With:[arr objectAtIndex:left]];
            if (result == NSOrderedSame) {
                [searchList addObject:[arr objectAtIndex:left]];
            }
            ++left;
        }
    }
}

- (void)searchText:(NSString *)searchText {
    isSearchActive = YES;
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
