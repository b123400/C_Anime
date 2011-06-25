//
//  MainViewController.m
//  C_Anime
//
//  Created by b123400 on 25/06/2011.
//  Copyright 2011 home. All rights reserved.
//

#import "MainViewController.h"
#import <AudioToolbox/AudioServices.h>

@implementation MainViewController


-(id)initWithCoder:(NSCoder *)aDecoder{
	//[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
	[[UIDevice currentDevice]setProximityMonitoringEnabled:YES];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(proximityStateDidChange:)
												 name:@"UIDeviceProximityStateDidChangeNotification"
											   object:nil];
	currectCharacter=CCharacterKimimaro;
	flipCount=2;
	flipSpeed=0.4;
	played_count=0;
	cameraCoverButton=[[UIButton buttonWithType:UIButtonTypeCustom]retain];
	cameraCoverButton.frame=CGRectMake(0, 0, 320, 480);
	[cameraCoverButton addTarget:self action:@selector(cameraCoverButtonDidTapped) forControlEvents:UIControlEventTouchUpInside];
	return [super initWithCoder:aDecoder];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)proximityStateDidChange:(NSNotification*)notification{
	if([[UIDevice currentDevice]proximityState]){
		[self rotateCenter];
	}
}

-(void)rotateCenter{
	[self playRandomSoundForCurrentCharacter];
	bgImageView.layer.zPosition=-10000;	
	[centerImageView.layer removeAllAnimations];
	for(int i=0;i<flipCount;i++){
		[self performSelector:@selector(flipFirstPart) withObject:nil afterDelay:flipSpeed*i];
		[self performSelector:@selector(flipSecondPart) withObject:nil afterDelay:flipSpeed*i+flipSpeed/2];
	}
}
-(void)playRandomSoundForCurrentCharacter{
	if(currectCharacter==CCharacterKimimaro){
		[self playSound:[NSString stringWithFormat:@"kimimaro%d.wav",(played_count%3)+1]];
	}else if(currectCharacter==CCharacterSatou){
		[self playSound:[NSString stringWithFormat:@"satou%d.wav",(played_count%2)+1]];
	}else if(currectCharacter==CCharacterMikuni){
		[self playSound:[NSString stringWithFormat:@"mikuni%d.wav",(played_count%4)+1]];
	}
	played_count++;
}
-(void)flipFirstPart{
	CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	rotateAnimation.duration=flipSpeed/2;
	rotateAnimation.repeatCount=1;
	rotateAnimation.fromValue= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0, 0, 0, 0)];
	float f = M_PI;
	CATransform3D aTransform = CATransform3DMakeRotation(f, 1, 0, 0);
	aTransform.m34 = 1.0 / -400;
	rotateAnimation.toValue=[NSValue valueWithCATransform3D:aTransform];
	rotateAnimation.delegate = self;
	rotateAnimation.removedOnCompletion = NO;
	centerImageView.layer.anchorPoint=CGPointMake(0.5, 0.5);
	centerImageView.center=CGPointMake(160,240);
	
	[centerImageView.layer addAnimation:rotateAnimation forKey:@"transform"];
}
-(void)flipSecondPart{
	CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	rotateAnimation.duration=flipSpeed/2;
	rotateAnimation.repeatCount=1;
	rotateAnimation.toValue= [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0.0, 0, 0, 0)];
	float f = M_PI;
	CATransform3D aTransform = CATransform3DMakeRotation(f, 1, 0, 0);
	aTransform.m34 = 1.0 / 400;
	rotateAnimation.fromValue=[NSValue valueWithCATransform3D:aTransform];
	rotateAnimation.delegate = self;
	rotateAnimation.removedOnCompletion = NO;
	centerImageView.layer.anchorPoint=CGPointMake(0.5, 0.5);
	centerImageView.center=CGPointMake(160,240);
	
	[centerImageView.layer addAnimation:rotateAnimation forKey:@"transform"];
}
-(void)playSound:(NSString*)filename{
	NSArray *array=[filename componentsSeparatedByString:@"."];
	
	SystemSoundID sounds[10];
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]];
	CFURLRef soundURL = (CFURLRef)[NSURL fileURLWithPath:soundPath];
	AudioServicesCreateSystemSoundID(soundURL, &sounds[0]);
	AudioServicesPlaySystemSound(sounds[0]);
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller withCharacter:(CCharacter)character flipCount:(int)_flipCount flipSpeed:(float)_flipSpeed{
	NSString *filePrefix;
	switch (character) {
		case CCharacterKimimaro:
			filePrefix=@"kimimaro";
			break;
		case CCharacterSatou:
			filePrefix=@"satou";
			break;
		case CCharacterMikuni:
			filePrefix=@"mikuni";
			break;
		default:
			return;
			break;
	}
	bgImageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@_bg.png",filePrefix]];
	centerImageView.image=[UIImage imageNamed:[NSString	 stringWithFormat:@"%@_center.png",filePrefix]];
	flipCount=_flipCount;
	flipSpeed=_flipSpeed;
	currectCharacter=character;
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    

	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	controller.flipCount=flipCount;
	controller.flipSpeed=flipSpeed;
	controller.character=currectCharacter;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}
-(IBAction)centerTapped{
	if(!pickerController){
		pickerController=[[UIImagePickerController alloc]init];
		pickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
		pickerController.delegate=self;
		pickerController.showsCameraControls=NO;
		
		UIImageView *newImageView=[[[UIImageView alloc]initWithImage:bgImageView.image] autorelease];
		/*UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cameraCoverButtonDidTapped)];
		[newImageView addGestureRecognizer:tap];
		[tap release];*/
		pickerController.cameraOverlayView=newImageView;
	}
	[self presentModalViewController:pickerController animated:NO];
	[[[[UIApplication sharedApplication] windows]lastObject] addSubview:cameraCoverButton];
}
-(void)cameraCoverButtonDidTapped{
	[cameraCoverButton removeFromSuperview];
	[pickerController dismissModalViewControllerAnimated:NO];
	[pickerController release];
	pickerController=nil;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	[picker dismissModalViewControllerAnimated:NO];
	[pickerController release];
	pickerController=nil;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:NO];
	[pickerController release];
	pickerController=nil;
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)dealloc {
	[cameraCoverButton release];
    [super dealloc];
}


@end
