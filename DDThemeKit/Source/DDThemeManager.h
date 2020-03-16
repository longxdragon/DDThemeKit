//
//  DDThemeManager.h
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDTraitCollection.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString * const DDThemeChangingNotification;

@interface DDThemeManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong) DDTraitCollection *currentTraitCollection;


@end

NS_ASSUME_NONNULL_END
