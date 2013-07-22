//
//  DetailView.h
//  SozlukIOS
//
//  Created by Rustam Ganeyev on 2/10/12.
//  Copyright (c) 2012 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface DetailViewController : UIViewController {
    IBOutlet UILabel *definitionLabel;
    IBOutlet UILabel *wordLabel;
}

@property(nonatomic, strong) Word *word;


@end
