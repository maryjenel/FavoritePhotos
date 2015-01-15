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
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabels;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property NSMutableArray *selectedDiceArray;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedDiceArray = [[NSMutableArray alloc] init];
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
        die.backgroundColor = [UIColor purpleColor];
    }

}

-(void)dieLabelTapped:(DieLabel *)label
{
    // If the label that was tapped has already been selected, deselect it
    // else select that label
    if ([self.selectedDiceArray containsObject:label])
    {
        [self.selectedDiceArray removeObject:label];
        label.backgroundColor = [UIColor purpleColor];
    }
    else
    {
        // Limit the label selection to either 1 or 5 or triples
        if ([label.text isEqualToString:@"1"] || [label.text isEqualToString:@"5"])
        {
            [self.selectedDiceArray addObject:label];
            label.backgroundColor = [UIColor greenColor];
        }
    }
}

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    // Rolls all unselected dice
    for (DieLabel *die in self.dieLabels)
    {
        if (![self.selectedDiceArray containsObject:die])
        {
            [die roll];
        }
    }

}

@end
