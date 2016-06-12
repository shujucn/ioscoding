#import <Foundation/Foundation.h>
#import "NSBundle+language.h"

//get language code
- (NSString *)getLanguageCodeFromLanguageName:(NSString *)language appendContryCode:(BOOL)needContryCode {
	// Xuan: iOS9 is using zh-Hans again
	BOOL iOS7 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0);
	BOOL iOS9 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0);
	
	NSString *zhCode, *enCode;
	if (needContryCode) {
		//
		zhCode = [self appendCountryCodeIfNeeded:((iOS7 || iOS9) ? @"zh-Hans" : @"zh")];
		enCode = [self appendCountryCodeIfNeeded:@"en"];
	} else {
		zhCode = (iOS7 || iOS9) ? @"zh-Hans" : @"zh";
		enCode = @"en";
	}
	
	NSDictionary *codeTable = @{@"简体中文": zhCode,
								@"English": enCode
								};
	return [codeTable objectForKey:language];
}
//app inside change 
- (void)switchLanguage {
	//Sync AppleLanguages Info
	NSString *code = [self getLanguageCodeFromLanguageName:self->selectedLng appendContryCode:YES];
	[[NSUserDefaults standardUserDefaults] setObject:@[code] forKey:@"AppleLanguages"];
	[[NSUserDefaults standardUserDefaults] synchronize];

	//During Runtime, update Bundle dong't need CountryCode
	NSString *language = [self getLanguageCodeFromLanguageName:self->selectedLng appendContryCode:NO];
	[NSBundle setLanguage:language];
	
	//reset rootViewController
	[self reloadRootViewController];
}

- (void)reloadRootViewController
{
	UIApplication * app = [UIApplication sharedApplication];
	AppDelegate *AppDelegate = (AppDelegate *)app.delegate;
	UIViewController *rootVCFromStoryBoard = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
	AppDelegate.window.rootHomeViewController = rootVCFromStoryBoard;
	
	//anther way to reste rootViewController by reset it's view
//	UINavigationController *appNaivigationController = (UINavigationController *)rootVCFromStoryBoard.contentViewController;
//	AppDelegate.AppNavigationController = appNaivigationController;
//	[AppDelegate.window.rootViewController addChildViewController:AppDelegate.rootHomeViewController];
//	AppDelegate.AppNavigationController.delegate = nil;
//	[AppDelegate.window.rootViewController.view addSubview:AppDelegate.rootHomeViewController.view];
//	[AppDelegate.rootHomeViewController didMoveToParentViewController:AppDelegate.window.rootViewController];
}


/*
 * ********************************************************************
 * Second: switch language by relaunch app (Kill app), It's pretty easy just need 
 * change the languange and kill app
 */

- (void)switchLanguageByKillApp {
	//Sync AppleLanguages Info
	NSString *code = [self getLanguageCodeFromLanguageName:self->selectedLng appendContryCode:YES];
	[[NSUserDefaults standardUserDefaults] setObject:@[code] forKey:@"AppleLanguages"];
	[[NSUserDefaults standardUserDefaults] synchronize];
    exit(0);
}
