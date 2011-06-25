//
//  C_AnimeAppDelegate.h
//  C_Anime
//
//  Created by b123400 on 25/06/2011.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum CCharacter {
	CCharacterKimimaro           = 0,
    CCharacterSatou			= 1,
    CCharacterMikuni			= 2,
} CCharacter;

@class MainViewController;

@interface C_AnimeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

