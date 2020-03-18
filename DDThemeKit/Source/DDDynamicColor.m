//
//  DDDynamicColor.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/18.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "DDDynamicColor.h"
#import "DDThemeManager.h"

#define DDColor(color) [[DDThemeManager manager] currentTraitCollection].userInterfaceStyle == DDUserInterfaceStyleDark ? color.darkColor : color.lightColor

@interface DDDynamicColor ()

@property (nonatomic, strong) UIColor *lightColor;
@property (nonatomic, strong) UIColor *darkColor;

@end

@implementation DDDynamicColor

+ (UIColor *)cardBgColor {
    DDDynamicColor *color = [DDDynamicColor new];
    color.lightColor = [UIColor whiteColor];
    color.darkColor = [UIColor blackColor];
    return DDColor(color);
}

@end
