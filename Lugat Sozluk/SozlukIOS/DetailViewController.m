//
//  DetailView.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/10/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize word;

- (void)viewDidLoad {
    [super viewDidLoad];
    wordLabel.text = word.word;
    NSArray *arr = [word.definition componentsSeparatedByString:@"*"];
    if (arr.count == 1) {
        definitionLabel.text = word.definition;
        return;
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSUInteger i  = 0;
    for (NSString *str in arr) {
        NSString *trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [result appendFormat:@"%d) %@\n", ++i, trimmedStr];
    }
    
    definitionLabel.text = result;
}

- (void)viewDidLayoutSubviews {
    [definitionLabel sizeToFit];
    
    [self.view layoutSubviews];
}

@end
