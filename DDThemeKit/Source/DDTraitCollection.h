//
//  DDTraitCollection.h
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DDUserInterfaceStyle) {
    DDUserInterfaceStyleUnspecified,
    DDUserInterfaceStyleLight,
    DDUserInterfaceStyleDark,
};

@interface DDTraitCollection : NSObject

+ (instancetype)traitCollectionWithUserInterfaceStyle:(DDUserInterfaceStyle)userInterfaceStyle;

@property (nonatomic, readonly) DDUserInterfaceStyle userInterfaceStyle;

@end

NS_ASSUME_NONNULL_END
