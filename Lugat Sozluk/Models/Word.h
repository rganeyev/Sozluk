//
// Created by User on 21.07.13.
// Copyright (c) 2013 rganeyev@gmail.com. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Word : NSObject

@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSString *definition;
@property (nonatomic, strong) NSString *all;
@property (nonatomic, strong) NSString *lowercaseWord;

+ (Word *)wordWith:(NSString *)string;

- (NSComparisonResult)compareWith:(NSString *)searchWord;
- (NSComparisonResult)compareSymbolWith:(unichar)symbol;
+ (unichar)convertSymbol:(unichar)ch;

@end