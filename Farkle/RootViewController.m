//
//  RootViewController.m
//  Farkle
//
//  Created by Yi-Chin Sun on 1/14/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController () <DieLabelDelegate, UIGestureRecognizerDelegate>

// A collection of UILabel IBoutlets
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabels;@property NSMutableArray *diceArray;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
        die.hidden = NO;
    }

}

-(void)dieLabelTapped:(DieLabel *)label
{
    [self.diceArray addObject:label];
    label.highlighted = !label.highlighted;

    
}


- (IBAction)onRollButtonPressed:(UIButton *)sender
{

    for (DieLabel *die in self.dieLabels) {
        [die roll];
    }

}

@end
