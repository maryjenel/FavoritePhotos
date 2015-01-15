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
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabels;@property NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet DieLabel *labelOne;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
        die.hidden = NO;
    }

}
- (IBAction)onTestTap:(UITapGestureRecognizer *)sender
{
}

-(void)dieLabelTapped:(DieLabel *)label
{
    [self.dice addObject:label];
    label.hidden = !label.hidden;
    
}
- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    [self.labelOne roll];
    for (DieLabel *die in self.dieLabels) {
        [die roll];
    }
}

@end
