//
//  DieLabel.m
//  Farkle
//
//  Created by Yi-Chin Sun on 1/14/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)roll
{
    int random = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", random];
}

-(IBAction)onTapped:(UITapGestureRecognizer *)sender
{
}

@end
