//
//  DieLabel.h
//  Farkle
//
//  Created by Yi-Chin Sun on 1/14/15.
//  Copyright (c) 2015 Yi-Chin Sun. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol DieLabelDelegate <NSObject> // this delegate conforms to NSObjects Delegate

-(void)dieLabelTapped:(UILabel *)label;


@end

@interface DieLabel : UILabel;
@property (nonatomic, weak) id<DieLabelDelegate> delegate;




- (void)roll;

@end
