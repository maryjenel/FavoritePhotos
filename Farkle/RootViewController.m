//
//  RootViewController.m
//  Farkle
//
//  Created by Yi-Chin Sun on 1/14/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "RootViewController.h"
#import "DieLabel.h"

@interface RootViewController ()

// A collection of UILabel IBoutlets
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabels;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    for (DieLabel *die in self.dieLabels) {
        [die roll];
    }
}

@end
