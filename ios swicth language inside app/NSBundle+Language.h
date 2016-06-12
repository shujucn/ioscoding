//
//  NSBundle+Language.h
//  MCompass
//
//  Created by shuju on 6/3/16.
//  Copyright © 2016 shujucn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  This category is for change app language insideApp without relaunch app.
 *  The solution is to swap the mainBundle of our application as soon as user 
 *  changes their language preferences inside the app.
 */
@interface NSBundle (Language)

+(void)setLanguage:(NSString *)language;

@end
