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


+ (Word *)wordWith:(NSString *)string {
    Word *result = [[Word alloc] init];
    if (result) {
        result.all = string;
        NSRange range = [string rangeOfString:@":"];
        if (range.location != NSNotFound) {
            result.word = [string substringToIndex:range.location];
            result.definition = [string substringFromIndex:range.location + 1];
        }
    }

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

+ (NSComparisonResult)compareTurkishSymbol:(unichar)ch With:(unichar)another {
    return ([Word convertSymbol:ch] - [Word convertSymbol:another]);
}

- (NSComparisonResult)compareWith:(NSString *)searchWord {
    NSString *lowSearchWord = [[NSString alloc] initWithString:[searchWord lowercaseString]];
    NSString *lowWord = [[NSString alloc] initWithString:[word lowercaseString]];
    NSUInteger len = [lowSearchWord length];
    for (NSUInteger i = 0; i < len; ++i) {
        NSComparisonResult res = [Word compareTurkishSymbol:[lowWord characterAtIndex:i] With:[lowSearchWord characterAtIndex:i]];
        if (res != NSOrderedSame) {
            return res;
        }
    }
    return NSOrderedSame;
}

@end