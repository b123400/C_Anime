//
//  FlipsideViewController.m
//  C_Anime
//
//  Created by b123400 on 25/06/2011.
//  Copyright 2011 home. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate,character,flipCount,flipSpeed;


- (void)viewDidLoad {
	characterSelect.selectedSegmentIndex=character;
	flipCountSlider.value=self.flipCount;
	flipSpeedSlider.value=self.flipSpeed;
	[self valueChanged];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}


- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self withCharacter:characterSelect.selectedSegmentIndex flipCount:flipCount flipSpeed:flipSpeed];
}
-(IBAction)valueChanged{
	flipCount=(int)flipCountSlider.value;
	flipCountLabel.text=[NSString stringWithFormat:@"%d",flipCount];
	flipCountSlider.value=flipCount;
	flipSpeedLabel.text=[NSString stringWithFormat:@"%f",flipSpeedSlider.value];
	flipSpeed=flipSpeedSlider.value;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
