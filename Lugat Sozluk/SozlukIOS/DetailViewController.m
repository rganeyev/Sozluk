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
    definitionLabel.text = word.definition;

    [definitionLabel sizeToFit];
}

@end
