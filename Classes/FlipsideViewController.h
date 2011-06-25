//
//  FlipsideViewController.h
//  C_Anime
//
//  Created by b123400 on 25/06/2011.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C_AnimeAppDelegate.h"

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	
	CCharacter character;
	int flipCount;
	float flipSpeed;
	
	IBOutlet UISegmentedControl *characterSelect;
	IBOutlet UILabel *flipCountLabel;
	IBOutlet UISlider *flipCountSlider;
	IBOutlet UILabel *flipSpeedLabel;
	IBOutlet UISlider *flipSpeedSlider;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;

@property (nonatomic, assign) CCharacter character;
@property (nonatomic, assign) int flipCount;
@property (nonatomic, assign) float flipSpeed;

-(IBAction)valueChanged;
- (IBAction)done:(id)sender;
@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller withCharacter:(CCharacter)character flipCount:(int)flipCount flipSpeed:(float)flipSpeed;
@end

