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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    wordLabel.text = wordDefinition;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [wordLabel release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
