//
//  DieLabel.m
//  Farkle
//
//  Created by Yi-Chin Sun on 1/14/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel



- (void)roll
{
    int random = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", random];
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender
{
    UILabel *label = (UILabel *)sender.view; //casting from UIView to UILabel
    [self.delegate dieLabelTapped:label];
}

@end
