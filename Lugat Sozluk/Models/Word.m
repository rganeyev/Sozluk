//
// Created by User on 21.07.13.
// Copyright (c) 2013 rganeyev@gmail.com. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Word.h"


@implementation Word

@synthesize all;
@synthesize word;
@synthesize definition;
@synthesize search;


+ (Word *)wordWith:(NSString *)jsonString {
    Word *result = [[Word alloc] init];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    result.word = [dict objectForKey:@"word"];
    result.definition = [dict objectForKey:@"definition"];
    result.search = [dict objectForKey:@"search"];
    result.all = [NSString stringWithFormat:@"%@: %@", result.word, [result.definition stringByReplacingOccurrencesOfString:@"\n" withString:@" "]];
    
    return result;

}

+ (unichar)convertSymbol:(unichar)ch {
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

- (NSComparisonResult)compareSymbolWith:(unichar)symbol {
    return [self compareSymbolAtIndex:0 With:symbol];
}

- (NSComparisonResult)compareSymbolAtIndex:(NSUInteger)index With:(unichar)symbol {
    return ([search characterAtIndex:index] - [Word convertSymbol:symbol]);
}

- (NSComparisonResult)compareWith:(NSString *)searchWord {
    NSUInteger len = searchWord.length;

    for (NSUInteger i = 0; i < len; ++i) {
        if (i >= search.length)
            return NSOrderedDescending;
        NSComparisonResult res = [self compareSymbolAtIndex:i With:[searchWord characterAtIndex:i]];
        if (res != NSOrderedSame) {
            return res;
        }
    }
    return NSOrderedSame;
}

@end