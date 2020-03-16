//
//  NSObject+Theme.m
//  DDThemeKit
//
//  Created by 许龙 on 2020/3/13.
//  Copyright © 2020 ldd. All rights reserved.
//

#import "NSObject+Theme.h"
#import "DDThemeManager.h"
#import <objc/runtime.h>

@interface DDDeallocExector : NSObject

@property (nonatomic, copy) void (^deallocBlock)(void);

@end

@implementation DDDeallocExector

+ (instancetype)exectorWithDeallocBlock:(void (^)(void))block {
    DDDeallocExector *exector = [DDDeallocExector new];
    exector.deallocBlock = block;
    return exector;
}

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
        self.deallocBlock = nil;
    }
}

@end


static void *kDDDeallocBlocks;
static void *kDDDeallocBlock;

@implementation NSObject (Theme)

- (void)addThemeProvider:(DDThemeProvider)provider {
    if (!provider) {
        return;
    }
    provider([DDThemeManager manager].currentTraitCollection);
    
    // 监听 dealloc 移除通知
    // 这边使用 __unsafe_unretained 关键字修饰，如果是 __weak 的话，会导致 dd_addDeallocBlock 回调里面获取不到 wself 对象
    if (!objc_getAssociatedObject(self, &kDDDeallocBlock)) {
        __unsafe_unretained typeof(self) wself = self;
        id exector = [self dd_addDeallocBlock:^{
            [[NSNotificationCenter defaultCenter] removeObserver:wself];
        }];
        objc_setAssociatedObject(self, &kDDDeallocBlock, exector, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [[self dd_providers] addObject:[provider copy]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DDThemeChangingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dd_themeChanging) name:DDThemeChangingNotification object:nil];
}

- (id)dd_addDeallocBlock:(void (^)(void))block {
    if (!block) {
        return nil;
    }
    NSMutableArray *list = objc_getAssociatedObject(self, &kDDDeallocBlocks);
    if (!list) {
        list = [NSMutableArray new];
        objc_setAssociatedObject(self, &kDDDeallocBlocks, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    for (DDDeallocExector *exector in list) {
        if (exector.deallocBlock == block) {
            return nil;
        }
    }
    DDDeallocExector *exector = [DDDeallocExector exectorWithDeallocBlock:block];
    [list addObject:exector];
    return exector;
}

- (void)dd_themeChanging {
    for (DDThemeProvider provider in [self dd_providers]) {
        provider([DDThemeManager manager].currentTraitCollection);
    }
}

- (NSMutableArray *)dd_providers {
    NSMutableArray *list = objc_getAssociatedObject(self, _cmd);
    if (!list) {
        list = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return list;
}

@end
