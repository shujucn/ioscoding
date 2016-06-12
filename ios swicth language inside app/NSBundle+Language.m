//
//  NSBundle+Language.m
//  MCompass
//
//  Created by shuju on 6/3/16.
//  Copyright © 2016 shujucn. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>

static const char BundleKey = 0;

@interface BundleEx : NSBundle
@end

@implementation BundleEx
//relaoad localizedStringForKey
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle *bundle = objc_getAssociatedObject(self, &BundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }
    else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

@end


@implementation NSBundle (Language)
//set language
+ (void)setLanguage:(NSString *)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[BundleEx class]);
    });
    id value = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
    objc_setAssociatedObject([NSBundle mainBundle], &BundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


