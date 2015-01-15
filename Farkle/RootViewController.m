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
@property NSMutableArray *selectableValues;
@property BOOL isPlayerOneTurn;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedDiceArray = [[NSMutableArray alloc] init];
    self.selectableValues = [NSMutableArray arrayWithObjects:@"1", @"5", nil];
    self.playerOneScoreLabel.text = @"0";
    self.playerTwoScoreLabel.text = @"0";
    self.isPlayerOneTurn = YES;
    for (DieLabel *die in self.dieLabels)
    {
        die.delegate = self;
        die.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:die.text]];
    }

}

-(void)dieLabelTapped:(DieLabel *)label
{
    // If the label that was tapped has already been selected, deselect it
    // else select that label
    if ([self.selectedDiceArray containsObject:label])
    {
        [self.selectedDiceArray removeObject:label];
        label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:label.text]];
    }
    else
    {
        BOOL isInArray = NO;
        // Limit the label selection to either 1 or 5 or triples
        for (int index = 0; index <self.selectableValues.count; index++)
        {
            if ([[self.selectableValues objectAtIndex:index] isEqualToString:label.text])
            {
                isInArray = TRUE;
            }
        }

        if (isInArray)
        {
            [self.selectedDiceArray addObject:label];
            NSMutableString *imageName = [[NSMutableString alloc] initWithString:label.text];
            [imageName appendString:@"h"];
            label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
        }
    }
}


- (IBAction)onRollButtonPressed:(UIButton *)sender
{
    //Removing all values in selectableValues except for 1 and 5
    [self.selectableValues subarrayWithRange:NSMakeRange(0, 2)];
    // Rolls all unselected dice
    for (DieLabel *die in self.dieLabels)
    {
        if (![self.selectedDiceArray containsObject:die])
        {
            [die roll];
        }
    }
    [self findsTripledValues];

}

- (IBAction)onBankButtonPressed:(id)sender
{
    int bankedPoints = [self calculatePoints];
    if (self.isPlayerOneTurn)
    {
        int newScore = bankedPoints + [self.playerOneScoreLabel.text intValue];
        self.playerOneScoreLabel.text = [NSString stringWithFormat: @"%i", newScore];
    }
    else
    {
        int newScore = bankedPoints + [self.playerTwoScoreLabel.text intValue];
        self.playerTwoScoreLabel.text = [NSString stringWithFormat: @"%i", newScore];
    }
    [self.selectedDiceArray removeAllObjects];
}


-(void)findsTripledValues
{
    for (int num = 1; num <= 6; num++)
    {
        int count = 0;
        for (DieLabel *die in self.dieLabels)
        {
            //only increment count if die is not already selected
            if (([die.text intValue] == num) && ![self.selectedDiceArray containsObject:die])
            {
                count++;
            }
        }
        if (count >= 3 )
        {
            [self.selectableValues addObject:[NSString stringWithFormat:@"%i", num]];
        }
    }
}

-(int)calculatePoints
{
    int oneCount = 0;
    int fiveCount = 0;
    int totalPoints = 0;
    
    for (DieLabel *die in self.selectedDiceArray)
    {
        int dieValue = [die.text intValue];
        if (dieValue == 1)
        {
            oneCount++;
        }
        else if (dieValue == 5)
        {
            fiveCount++;
        }
        else
        {
            totalPoints = totalPoints + (dieValue * 100);
        }
    }
    totalPoints = totalPoints / 3; //the tripled value will be added 3 times, so need to divide by 3.

    if (oneCount >=3)
    {
        totalPoints = totalPoints + 1000;
    }
    else
    {
        totalPoints = oneCount * 100;
    }

    if (fiveCount >=3)
    {
        totalPoints = totalPoints + 500;
    }
    else
    {
        totalPoints = totalPoints + fiveCount * 50;
    }


    return totalPoints;
}

@end
