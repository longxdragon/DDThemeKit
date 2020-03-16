//
//  DDTraitCollection.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "DDTraitCollection.h"

@implementation DDTraitCollection

+ (instancetype)traitCollectionWithUserInterfaceStyle:(DDUserInterfaceStyle)userInterfaceStyle {
    DDTraitCollection *traitCollection = [DDTraitCollection new];
    traitCollection->_userInterfaceStyle = userInterfaceStyle;
    return traitCollection;
}

@end

