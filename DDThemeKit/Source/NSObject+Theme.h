//
//  NSObject+Theme.h
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DDThemeProvider)(DDTraitCollection *traitCollection);

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#define AddThemeProvider(object, block) \
@weakify(object);\
[object addThemeProvider:^(DDTraitCollection * _Nonnull traitCollection) {\
    @strongify(object)\
    if (!object) return;\
    if (block) {\
        block(traitCollection);\
    }\
}];\

@interface NSObject (Theme)

- (void)addThemeProvider:(DDThemeProvider)provider;

@end

NS_ASSUME_NONNULL_END
