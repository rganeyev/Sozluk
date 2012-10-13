//
//  DetailView.m
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/10/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

@synthesize wordDefinition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    wordLabel.text = wordDefinition;
    NSRange range = [wordDefinition rangeOfString:@":"];
    if (range.location != NSNotFound) {
        wordLabel.text = [wordDefinition substringToIndex:range.location];
        definitionLabel.text = [wordDefinition substringFromIndex:range.location + 1];
    }

    [definitionLabel sizeToFit];
}

- (void)dealloc {
    [definitionLabel release];
    [wordLabel release];

    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
