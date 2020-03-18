//
//  DDDynamicImage.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/18.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "DDDynamicImage.h"
#import "DDThemeManager.h"

@implementation DDDynamicImage

+ (UIImage *)imageWithName:(NSString *)name {
    return [[DDThemeManager manager] currentTraitCollection].userInterfaceStyle == DDUserInterfaceStyleDark ? [UIImage imageNamed:[NSString stringWithFormat:@"%@_night", name]] : [UIImage imageNamed:name];
}

@end
