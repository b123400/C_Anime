//
//  MainViewController.h
//  C_Anime
//
//  Created by b123400 on 25/06/2011.
//  Copyright 2011 home. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "C_AnimeAppDelegate.h"
#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	IBOutlet UIImageView *bgImageView;
	IBOutlet UIImageView *centerImageView;
	
	CCharacter currectCharacter;
	int flipCount;
	float flipSpeed;
	
	int played_count;
	
	UIButton *cameraCoverButton;
	UIImagePickerController *pickerController;
}

- (IBAction)showInfo:(id)sender;
-(IBAction)centerTapped;

@end
