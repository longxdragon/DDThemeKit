//
//  DDThemeManager.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "DDThemeManager.h"

NSString *const DDThemeChangingNotification = @"DDThemeChangingNotification";

@interface DDThemeManager ()

@end

@implementation DDThemeManager

+ (instancetype)manager {
    static DDThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DDThemeManager alloc] init];
    });
    return manager;
}

- (void)setCurrentTraitCollection:(DDTraitCollection *)currentTraitCollection {
    if (_currentTraitCollection != currentTraitCollection) {
        _currentTraitCollection = currentTraitCollection;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DDThemeChangingNotification object:nil];
    }
}

@end
